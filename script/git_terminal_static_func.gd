class_name GitTerminalStaticFunc
extends Node


static func size_of_file_in_bytes(file_path_absolute: String) -> int:
	if FileAccess.file_exists(file_path_absolute):
		var file = FileAccess.open(file_path_absolute, FileAccess.READ)
		if file:
			return file.get_length()
	return -1

static func size_of_file_in_mega_bytes(file_path_absolute: String) -> float:
	var size_in_bytes = size_of_file_in_bytes(file_path_absolute)
	if size_in_bytes >= 0:
		return size_in_bytes / (1024 * 1024)
	return -1.0

static func is_file_bigger_that_mega_bytes(file_path_absolute: String, mega_bytes: float) -> bool:
	var size_in_mega_bytes = size_of_file_in_mega_bytes(file_path_absolute)
	if size_in_mega_bytes >= 0:
		return size_in_mega_bytes > mega_bytes
	return false

static func get_all_files_recursive_in_folder(folder_path_absolute: String) -> Array:
	var result = []
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if not file_name.begins_with("."):
					var item_path = folder_path_absolute + "/" + file_name
					if FileAccess.file_exists(item_path):
						result.append(item_path)
					elif DirAccess.dir_exists_absolute(item_path):
						result += get_all_files_recursive_in_folder(item_path)
				file_name = dir.get_next()
	return result

static func get_all_files_bigger_that_mega_bytes_recursive(folder_path_absolute: String, mega_bytes: float) -> Array:
	var result = []
	var all_files = get_all_files_recursive_in_folder(folder_path_absolute)
	for file_path in all_files:
		if is_file_bigger_that_mega_bytes(file_path, mega_bytes):
			result.append(file_path)
	return result
	

static func create_or_override_file_with_content(file_path_absolute: String, content: String) -> void:
	var file = FileAccess.open(file_path_absolute, FileAccess.WRITE)
	if file:
		file.store_string(content)

static func create_or_override_git_ignore_in_folder(folder_path_absolute: String, content: String) -> void:
	var path = folder_path_absolute + "/.gitignore"
	create_or_override_file_with_content(path, content)


static func get_git_ignore_content_for_folder(folder_path_absolute: String) -> String:
	var path = folder_path_absolute + "/.gitignore"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		if file:
			return file.get_as_text()
	return ""


static func is_folder_have_git_root(folder_path_absolute: String) -> bool:
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		return DirAccess.dir_exists_absolute(folder_path_absolute + "/.git")
	return false


static func get_parent_of_folder(folder_path_absolute: String) -> String:
	var os_separator = "\\" if OS.get_name() == "Windows" else "/"
	var parts = folder_path_absolute.split(os_separator)
	if parts.size() <= 1:
		return ""
	parts.remove_at(parts.size() - 1)
	return "/".join(parts) if os_separator == "/" else "\\".join(parts)

#static func get_git_from_parent_folder(folder_path_absolute: String) -> String:


static func get_git_root_folder_from_parent(folder_path_absolute: String) -> String:
	var parent = get_parent_of_folder(folder_path_absolute)
	if parent == "":
		return ""
	if is_folder_have_git_root(parent):
		return parent
	return get_git_root_folder_from_parent(parent)


static func is_folder_have_git_ignore(folder_path_absolute: String) -> bool:
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if file_name == ".gitignore":
					return true
				file_name = dir.get_next()
	return false

static func create_folder_if_not_exist(where_path:String) -> void:
	# in godot
	if (not DirAccess.dir_exists_absolute(where_path)):
		DirAccess.make_dir_absolute(where_path)
		

static func create_override_git_keep_in_folder(where_path: String) -> void:
	var path = where_path + "/.gitkeep"
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string("Keep")
		
static func remove_git_keep_in_folder(folder_path: String) -> void:
	var path = folder_path + "/.gitkeep"
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)

static func is_folder_empty(folder_path_absolute: String) -> bool:
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if not file_name.begins_with("."):
					return false
				file_name = dir.get_next()
			return true
	return false
	
static func update_git_keep_in_folder(folder_path_absolute: String) -> void:
		
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var is_folder_empty = is_folder_empty(folder_path_absolute)
		if is_folder_empty:
			create_override_git_keep_in_folder(folder_path_absolute)
		else:
			remove_git_keep_in_folder(folder_path_absolute)

static func update_git_keep_in_folder_recusrive(folder_path_absolute: String) -> void:
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		update_git_keep_in_folder(folder_path_absolute)
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if not file_name.begins_with("."):
					var sub_path = folder_path_absolute + "/" + file_name
					if DirAccess.dir_exists_absolute(sub_path):
						update_git_keep_in_folder_recusrive(sub_path)
				file_name = dir.get_next()

static func is_file_exists(file_path_absolute: String) -> bool:
	return FileAccess.file_exists(file_path_absolute)

static func is_folder_exists(folder_path_absolute: String) -> bool:
	return DirAccess.dir_exists_absolute(folder_path_absolute)

static func has_folder_empty(folder_path_absolute: String) -> bool:
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if not file_name.begins_with("."):
					return false
				file_name = dir.get_next()
			return true
	return false


static func get_files_and_folder_in_folder_not_recursive(folder_path_absolute: String) -> Array:
	var result = []
	if DirAccess.dir_exists_absolute(folder_path_absolute):
		var dir = DirAccess.open(folder_path_absolute)
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				result.append(file_name)
				file_name = dir.get_next()
	return result

static func get_all_files_and_folders_recursive(folder_path_absolute: String) -> Array:
	var result = []
	if not DirAccess.dir_exists_absolute(folder_path_absolute):
		return result
	
	var dir = DirAccess.open(folder_path_absolute)
	if not dir:
		return result
	
	# Get all items in current directory
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not file_name.begins_with("."):
			var item_path = folder_path_absolute + "/" + file_name
			result.append(item_path)
			
			# Recursively get items from subdirectories
			if DirAccess.dir_exists_absolute(item_path):
				result += get_all_files_and_folders_recursive(item_path)
		
		file_name = dir.get_next()
	
	return result


static func remove_all_empty_folders_recursive(where_path: String) -> void:
	var files_and_folders = get_all_files_and_folders_recursive(where_path)
	for path in files_and_folders:		
		if DirAccess.dir_exists_absolute(path):
			if has_folder_empty(path):
				DirAccess.remove_absolute(path)


	#public static void RemoveAllEmptyFolders(string wherePath)
	#{
		#RemoveGitKeepInFolders(wherePath);
		#string[] paths = GetAllFolders(wherePath, true);
		#foreach (var path in paths)
		#{
			#if (Directory.Exists(path)) {
				#string[] files = Directory.GetFiles(path);
				#if (files.Length == 0) {
					#Directory.Delete(path, true);
					#if (File.Exists(path + ".meta"))
						#File.Delete(path + ".meta");
				#}
			#}
		#}
		#CreateGitKeepInEmptyFolders(wherePath);
	#}



	#public static void CreateGitKeepInEmptyFolders(string wherePath, string keepTextContent = "Hey mon ami, tu aimes ça manger des patates ?")
	#{
		#string[] paths = GetAllFolders(wherePath, true);
		#foreach (var path in paths)
		#{
			#if (Directory.Exists(path) && Directory.GetFiles(path).Length == 0)
			#{
				#File.WriteAllText(path + "/.gitkeep", keepTextContent);
			#}
		#}
	#}
#
	#public static void RemoveGitKeepInFolders(string wherePath)
	#{
		#string[] paths = GetAllFolders(wherePath, true);
		#foreach (var path in paths)
		#{
			#if (Directory.Exists(path))
			#{
				#if (File.Exists(path + "/.gitkeep"))
					#File.Delete(path + "/.gitkeep");
			#}
		#}
	#}
	#public static void RefreshGitKeepInEmptyFolder(string wherePath, string keepTextContent = "Hey mon ami, tu aimes ça manger des patates ?")
	#{
		#RemoveGitKeepInFolders(wherePath);
		#CreateGitKeepInEmptyFolders(wherePath);
	#}
#
	#public static void AddFileInEmptyFolder(string folderPath)
	#{
		#List<string> folders = GetAllFolders(folderPath, true).ToList();
		#FindRemoveFilesIn(ref folders, ".git");
		#for (int i = 0; i < folders.Count; i++)
		#{
			#string path = folders[i];
			#string[] files = Directory.GetFiles(path);
			#string emptyPath = path + "\\empty.txt";
			#string emptyPathMeta = path + "\\empty.txt.meta";
			#files = Remove(files, emptyPathMeta, emptyPath);
			#//            UnityEngine.Debug.Log("<> " + path + " : " + files.Length);
#
			#bool isEmpty = files.Length <= 0;
#
			#if (isEmpty)
			#{
				#File.WriteAllText(emptyPath, "Avoid empty folder");
			#}
			#else
			#{
				#if (File.Exists(emptyPath))
					#File.Delete(emptyPath);
				#if (File.Exists(emptyPathMeta))
					#File.Delete(emptyPathMeta);
			#}
		#}
	#}
#
	#public static void GetGitInDirectory(string path, out GitLinkOnDisk gitLink, bool searchInChildens)
	#{
		#List<GitLinkOnDisk> gits;
		#GetGitsInDirectory(path, out gits, searchInChildens);
		#if (gits.Count > 0)
			#gitLink = gits[0];
		#else gitLink = null;
#
	#}
#
	#private static string[] Remove(string[] files, string emptyPathMeta, string emptyPath)
	#{
		#List<string> f = new List<string>();
		#for (int i = 0; i < files.Length; i++)
		#{
			#if (files[i] == emptyPath || files[i] == emptyPathMeta)
			#{ }
			#else {
				#f.Add(files[i]);
			#}
#
		#}
		#return f.ToArray();
	#}
#
	#public static void GetGitsInDirectory(string directoryPath, out List<GitLinkOnDisk> found, bool withChildrensFolders = true)
	#{
		#found = GetGitsInGivenDirectories(GetAllFolders(directoryPath, withChildrensFolders, withChildrensFolders));
	#}
	#public static void GetGitsInDirectory(string directoryPath, out List<GitLinkOnDisk> found, bool useRootFolder, bool withChildrensFolders = true)
	#{
		#found = GetGitsInGivenDirectories(GetAllFolders(directoryPath, useRootFolder, withChildrensFolders));
	#}
#
#
	#public static void GetGitsFromLeaf(List<GitLinkOnDisk> givenGits, out GitLinkOnDisk gitOnTopOfPath)
	#{
		#if (givenGits.Count <= 0) gitOnTopOfPath = null;
		#else
			#gitOnTopOfPath = givenGits.OrderByDescending(k => k.GetDirectoryPath().Length).First();
	#}
	#public static void GetGitsOnFromRoot(List<GitLinkOnDisk> givenGits, out GitLinkOnDisk gitOnTopOfPath)
	#{
		#if (givenGits.Count <= 0) gitOnTopOfPath = null;
		#else
			#gitOnTopOfPath = givenGits.OrderBy(k => k.GetDirectoryPath().Length).First();
	#}
	#public enum PathReadDirection { RootToLeaf, LeafToRoot }
	#public static void GetGitInParents(string path, PathReadDirection readMode, out GitLinkOnDisk git) {
		#List<GitLinkOnDisk> links;
		#GetGitsInParents(path, out links);
		#if (readMode == PathReadDirection.RootToLeaf)
			#GetGitsOnFromRoot(links, out git);
		#else
			#GetGitsFromLeaf(links, out git);
	#}
	#public static void GetGitsInParents(string path, out List<GitLinkOnDisk> links)
	#{
		#links = new List<GitLinkOnDisk>();
		#string[] parentsPath = UnityPaths.GetAllParents(path, true);
		#for (int i = 0; i < parentsPath.Length; i++)
		#{
			#if (IsPathContaintGitRoot(parentsPath[i]))
			#{
				#GitLinkOnDisk gd = new GitLinkOnDisk(parentsPath[i]);
				#links.Add(gd);
			#}
		#}
	#}
#
	#private static bool IsPathContaintGitRoot(object path)
	#{
		#return Directory.Exists(path + "/.git");
	#}
#
	#public static bool IsPathInAssetFolder(string currentPath)
	#{
		#currentPath = currentPath.Replace("\\", "/");
		#string path = Directory.GetCurrentDirectory().Replace("\\", "/") + "/Assets";
		#return currentPath.IndexOf(path) > -1;
	#}
	#public static bool IsPathOutsideOfAssetFolder(string currentPath)
	#{
		#return !IsPathInAssetFolder(currentPath);
	#}
	#public static bool IsPathInProjectFolder(string currentPath)
	#{
		#currentPath = currentPath.Replace("\\", "/");
		#string path = Directory.GetCurrentDirectory().Replace("\\", "/");
		#return currentPath.IndexOf(path) > -1;
#
	#}
#
#
#
	#public static bool IsPathOutsideOfProjectFolder(string currentPath)
	#{
		#return !IsPathInProjectFolder(currentPath);
	#}
	#public static bool IsGitInsideProject(string currentPath)
	#{
		#return !IsPathOutsideOfAssetFolder(currentPath);
	#}
#
	#public static List<GitLinkOnDisk> GetGitsInGivenDirectories(string[] directoriesPath)
	#{
		#List<GitLinkOnDisk> packages = new List<GitLinkOnDisk>();
		#for (int i = directoriesPath.Length - 1; i >= 0; i--)
		#{
#
			#string p = directoriesPath[i];
			#bool isGitFolder = IsPathHasGitRootFolder(p);
			#if (isGitFolder)
				#packages.Add(new GitLinkOnDisk(p));
		#}
		#return packages;
	#}
#
#
	#public static bool IsPathHasGitRootFolder(string directoryPath) {
		#return Directory.Exists(directoryPath + "/.git");
	#}
#
	#public static bool IsPathIsGitRootFormat(string directoryPath)
	#{ if (directoryPath.Length < 6) return false;
#
		#return directoryPath.ToLower().IndexOf("/.git") == directoryPath.Length - 5
				#||
				#directoryPath.ToLower().IndexOf("\\.git") == directoryPath.Length - 5;
	#}
#
	#public static bool IsGitFolderWihtUrl(string directoryPath)
	#{
		#if (!IsPathHasGitRootFolder(directoryPath))
			#return false;
		#string url = "";
		#GetGitUrl(directoryPath, out url);
		#return string.IsNullOrWhiteSpace(url);
	#}
#
	#public static bool IsFolderEmpty(string whereGitIs)
	#{
		#if (!Directory.Exists(whereGitIs))
			#return false;
		#return Directory.GetFiles(whereGitIs).Length <= 0;
	#}
#
#
#
	#private static void FindRemoveFilesIn(ref List<string> folders, string toFound)
	#{
		#for (int i = folders.Count - 1; i >= 0; i--)
		#{
			#if (folders[i].IndexOf(toFound) > -1)
				#folders.RemoveAt(i);
		#}
	#}
#
#
#
#
	#public static string[] GetAllFolders(string folderPath, bool containGivenFolder, bool withChildren = true) {
		#if (string.IsNullOrEmpty(folderPath.Trim()))
			#return new string[0];
#
		#List<string> pathList = Directory.GetDirectories(folderPath, "*", withChildren ? SearchOption.AllDirectories : SearchOption.TopDirectoryOnly).ToList();
		#if (containGivenFolder)
			#pathList.Add(folderPath);
		#return pathList.ToArray();
	#}
#
#
#
	#public static void OpenCmd(string gitDirectoryPath)
	#{
		#if (gitDirectoryPath.Length < 2) return;
#
		#char disk = 'C';
		#if (gitDirectoryPath[1] == ':')
			#disk = gitDirectoryPath[0];
		#//string cmd = disk + ":" + "&" + "cd \"" + gitDirectoryPath + "\"";
#
		#string strCmdText;
		#strCmdText = "/K " + disk + ":" + " && cd " + gitDirectoryPath + " && git status";
		#System.Diagnostics.Process process = new System.Diagnostics.Process();
		#process.StartInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
		#process.StartInfo.FileName = "cmd.exe";
		#process.StartInfo.Arguments = strCmdText;
		#process.Start();
	#}
	#public static void Clone(string gitUrl, string gitDirectoryPath)
	#{
		#string cmd = "git clone \"" + gitUrl + "\" \"" + gitDirectoryPath + "\"";
		#WindowCMD.RunCommands(new string[] {
				 #cmd
		  #}, gitDirectoryPath,true,out WindowCMDCallback callback);
		#Debug.Log(cmd);
		#Debug.Log(JsonUtility.ToJson(callback));
	#}
#
	#public static void Pull(string gitDirectoryPath)
	#{
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git pull"
		  #}, gitDirectoryPath);
	#}
	#public static void Add(string gitDirectoryPath)
	#{
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git add -A"
		  #}, gitDirectoryPath);
	#}
	#public static void Commit(string gitDirectoryPath, string commitDescription = "")
	#{
		#if (string.IsNullOrWhiteSpace(commitDescription))
			#commitDescription = GetTime();
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git commit -m \"Save: " + commitDescription + "\""
		  #}, gitDirectoryPath);
	#}
#
	#public static string GetTime()
	#{
		#return DateTime.Now.ToString("yyyy_MM_dd_HH_mm", CultureInfo.InvariantCulture);
	#}
#
	#public static void Push(string gitDirectoryPath)
	#{
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git push"
		  #}, gitDirectoryPath);
	#}
	#public static bool m_debugState = false;
	#public static void SetDebugOn(bool useDebug)
	#{
		#m_debugState = useDebug;
	#}
	#public static bool GetDebugState() { return m_debugState; }
#
	#public static void AddFolderInSafeDirectory(string gitDirectoryPath) {
	   #
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
		  #}, gitDirectoryPath);
#
	#}
	#public static string GetAddSaveCommandAsString(string gitDirectoryPath) {
#
		#string p = "git config --global --add safe.directory \"" + gitDirectoryPath + "\"";
		#p= p.Replace("\\", "/");
		#//Debug.Log(p);
		#return p;
	#}
#
	#public static void AddCommitPull(string gitDirectoryPath, string commitDescription = "")
	#{
		#if (string.IsNullOrWhiteSpace(commitDescription))
			#commitDescription = GetTime();
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git add -A",
				#"git commit -m \"Save: " + commitDescription + "\"",
				#"git pull"
		  #}, gitDirectoryPath);
	#}
	#public static void PullPushWithAddAndCommit(string gitDirectoryPath, string commitDescription = "")
	#{
		#if (string.IsNullOrWhiteSpace(commitDescription))
			#commitDescription = GetTime();
#
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git add -A",
				#"git commit -m \"Save: " + commitDescription + "\"",
				#"git pull",
				#"git add -A",
				#"git commit -m \"Merge: "+ commitDescription + "\"",
				#"git push"
		  #}, gitDirectoryPath);
	#}
	#
#
	#public static void AddCommitAndPush(string gitDirectoryPath, string commitDescription = "")
	#{
		#if (string.IsNullOrWhiteSpace(commitDescription))
			#commitDescription = GetTime();
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(gitDirectoryPath),
				#"git add -A",
				#"git commit -m \"" + commitDescription + "\"",
				#"git push"
		  #}, gitDirectoryPath);
	#}
#
#
	#public static void CreateLocal(string directoryPath)
	#{
		#System.IO.Directory.CreateDirectory(directoryPath);
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(directoryPath),
				#"git init .",
				#"git add .",
				#"git commit -m \"First commit\"",
		  #}, directoryPath);
		#//$ git push -u origin master
#
	#}
	#public static void PushLocalToNewOnline(GitServer server, string directoryPath, string userName, string newRepoName, out string gitCreatedUrl)
	#{
		#gitCreatedUrl = "";
		#switch (server)
		#{
			#//case GitServer.GitHub:
			#//    PushLocalToGitHub(directoryPath, userName, newRepoName, out gitCreatedUrl);
			#//    break; 
			#case GitServer.GitLab:
				#PushLocalToGitLab(directoryPath, userName, newRepoName, out gitCreatedUrl);
				#break;
			#case GitServer.GitHub:
				#PushLocalToGitHub(directoryPath, userName, newRepoName, out gitCreatedUrl);
				#break;
			#default:
				#break;
		#}
	#}
	#public static void PushLocalToGitHub(string directoryPath, string userName, string newRepoName, out string gitCreatedUrl)
	#{
		#UnityEngine.Debug.LogWarning("Push on GitHub is not implemented because of it security complexity");
		#gitCreatedUrl = "https://github.com/new?name=" + newRepoName;
#
		#//     gitCreatedUrl = "https://github.com/"+userName+"/"+newRepoName+".git";
		#//  if (!string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(newRepoName))
		#//        gitCreatedUrl = "https://github.com/" + userName + "/" + newRepoName + ".git";
		#//    else
		#//        gitCreatedUrl = "";
		#//    //https://kbroman.org/github_tutorial/pages/init.html
		#//    RunCommands(new string[] {
		#//                "git add .",
		#//                "git commit -m \"Local to Remote\"",
#
		#////                "git remote add origin git@github.com:"+userName+"/"+newRepoName+".git",
		#//                "git remote add origin https://github.com/"+userName+"/"+newRepoName+"",
		#//                "git push --set-upstream https://github.com/"+userName+"/"+newRepoName+".git master",
		#//                "git push -u origin master"
		#//          }, directoryPath);
	#}
	#public static void PushLocalToGitLab(string directoryPath, string userName, string newRepoName, out string gitCreatedUrl)
	#{
		#QuickGit.CreateGitKeepInEmptyFolders(directoryPath);
		#directoryPath = UnityPaths.ReplaceByBackslash(directoryPath);
		#UnityEngine.Debug.Log("" + userName + "????" + newRepoName);
		#UnityEngine.Debug.Log("" + "????" + directoryPath);
		#if (!string.IsNullOrEmpty(userName) && !string.IsNullOrEmpty(newRepoName))
			#gitCreatedUrl = "https://gitlab.com/" + userName + "/" + newRepoName + ".git";
		#else
			#gitCreatedUrl = "";
#
		#//https://docs.gitlab.com/ee/gitlab-basics/create-project.html
		#//git push --set-upstream https://gitlab.example.com/namespace/nonexistent-project.git master
		#//git push --set-upstream address/your-project.git
		#WindowCMD.RunCommands(new string[] {
				#GetAddSaveCommandAsString(directoryPath),
				#"git add .",
				#"git commit -m \"Local to Remote\"",
				#"git push --set-upstream \"https://gitlab.com/"+userName+"/"+newRepoName+".git\" master",
				#"git push -u origin master"
		  #}, directoryPath);
#
	#}
	#public static void RemoveFolder(string directoryPath)
	#{
		#RemoveFiles(directoryPath);
#
		#WindowCMD.RunCommands(new string[] {
				#"del /S /F /AH "+directoryPath,
				#"rmdir "+directoryPath
		  #}, directoryPath);
	#}
	#public static void RemoveFiles(string directoryPath)
	#{
		#string[] pathfiles = Directory.GetFiles(directoryPath, "*", SearchOption.AllDirectories);
		#string[] pathfilesOwn = Directory.GetFiles(directoryPath, "*", SearchOption.AllDirectories);
#
		#for (int i = 0; i < pathfilesOwn.Length; i++)
		#{
			#pathfilesOwn[i] = "takeown / A / F" + pathfilesOwn[i];
		#}
		#for (int i = 0; i < pathfiles.Length; i++)
		#{
#
			#pathfiles[i] = "del /F /AH " + pathfiles[i];
		#}
		#List<string> files = new List<string>();
		#files.AddRange(pathfiles);
		#files.AddRange(pathfilesOwn);
		#WindowCMD.RunCommands(files.ToArray(), directoryPath);
	#}
#
	#public static bool GetGitUrl(string rootDirectoryPath, out string url)
	#{
		#url = "";
		#if (string.IsNullOrEmpty(rootDirectoryPath))
			#return false;
		#string filePath = rootDirectoryPath + "/.git/config";
		#if (!File.Exists(filePath))
			#return false;
#
		#string[] lines = File.ReadAllLines(filePath);
		#string gitUrl = "";
		#for (int i = 0; i < lines.Length; i++)
		#{
			#int urlIndex = lines[i].IndexOf("url =");
			#if (urlIndex >= 0)
			#{
				#gitUrl = lines[i].Substring(urlIndex + "url =".Length).Trim();
				#break;
			#}
#
		#}
		#if (gitUrl == "")
		#{
			#for (int i = 0; i < lines.Length; i++)
			#{
				#int urlIndex = lines[i].IndexOf("remote =");
				#if (urlIndex >= 0)
				#{
					#gitUrl = lines[i].Substring(urlIndex + "remote =".Length).Trim();
					#break;
				#}
			#}
#
		#}
#
		#url = gitUrl;
		#return !string.IsNullOrEmpty(url);
	#}
	#public enum GitServer { GitHub, GitLab }
#
	#public static void GetLastRevision(string absolutePathOfRepository, out bool found, out string revisionId)
	#{
		#string path = absolutePathOfRepository + "/.git/refs/heads/master";
		#revisionId = "";
		#found = File.Exists(path);
		#if (found)
			#revisionId = File.ReadAllText(path).Trim();
#
	#}
#
	#public static void LoadCommitsFromDateToDate(string [] repositoriesAbsolutePath, GitDateFormat dateFromFormat, GitDateFormat dateToFormat, out List<LogCommitReceived> commits, out List<WindowCMDCallback> callbacks, int maxToRecover = 50000)
	#{
		#callbacks= new List<WindowCMDCallback>();
#
		#List<LogCommitReceived> receivedCommits = new List<LogCommitReceived>();
		#commits = new List<LogCommitReceived>();
		#for (int i = 0; i< repositoriesAbsolutePath.Length; i++)
		#{
			#WindowCMDCallback callback;
			#QuickGit.LoadCommitsFromDateToDate(repositoriesAbsolutePath[i], dateFromFormat, dateToFormat, out receivedCommits, out callback, maxToRecover);
			#callbacks.Add(callback);
			#commits.AddRange(receivedCommits);
		#}
	#}
	#public static void LoadCommitsFromDateToDate(string repositoryAbsolutePath, GitDateFormat dateFromFormat, GitDateFormat dateToFormat, out List<LogCommitReceived> commits, out WindowCMDCallback callback, int maxToRecover=50000)
	#{
		#commits = new List<LogCommitReceived>();
		#
		#string cmd = string.Format("git log --after=\"{0}\" --before=\"{1}\" --pretty=format:\"%H|%an|%ae|%ad|%s\" --date=format:%Y:%m:%d:%H:%M:%S:%z -n {2}",
			#dateFromFormat.GetGitTimeFormat(), dateToFormat.GetGitTimeFormat(), maxToRecover);
		#WindowCMD.RunCommands(new string[] { cmd }, repositoryAbsolutePath, false, out callback);
		#string[] receivedLines = callback.GetReceivedTextAsLines();
		#Debug.Log("Received Lines:" + receivedLines.Length);
		#Debug.Log("Cmd:" + cmd);
		#for (int i = 0; i < receivedLines.Length; i++)
		#{
			#//3a8c1a82146c13cb9e26359aaa73d49b9c81ca84|ddd|ddd@gmail.com|2020:06:19:09:53:30:+0200|Commit
			#//50d63eb71ce042349f45ba4a3bd80da925bac915|Eloi Stree|eloistree@gmail.com|2020:06:19:07:36:50:+0200|Commit
			#string[] lineTokens = receivedLines[i].Split('|');
			#if (lineTokens.Length == 5)
			#{
				#LogCommitReceived commit;
				#ConvertTableToCommitFromStringOfConsole(lineTokens, out commit);
				#commits.Add(commit);
			#}
		#}
	#}
#
	#public static void ConvertTableToCommitFromStringOfConsole(string[] m_prettyTokens, out LogCommitReceived commit)
	#{
#
		#commit = new LogCommitReceived();
		#commit.SetCommitId(m_prettyTokens[0].Trim());
		#commit.SetAuthor(m_prettyTokens[1].Trim());
		#commit.SetMail(m_prettyTokens[2].Trim());
		#string toParse = m_prettyTokens[3].Trim();
		#commit.SetLabel(m_prettyTokens[4].Trim());
#
		#string[] dateToken = toParse.Split(':');
		#int year = int.Parse(dateToken[0]);
		#int month = int.Parse(dateToken[1]);
		#int day = int.Parse(dateToken[2]);
		#int hour = int.Parse(dateToken[3]);
		#int minute = int.Parse(dateToken[4]);
		#int second = int.Parse(dateToken[5]);
		#int millisecond = int.Parse(dateToken[6].Replace("+", ""));
		#commit.SetDate(year, month, day, hour, minute, second, millisecond);
	#}
#}
#[System.Serializable]
#public class GitDateFormat
#{
	#public int year = 2020;
	#public int month = 01;
	#public int day = 01;
	#public int hour = 12;
	#public int minute = 00;
	#public int second = 00;
	#public string GetGitTimeFormat()
	#{
		#return string.Format("{0:0000}-{1:00}-{2:00} {3:00}:{4:00}:{5:00}", year, month, day, hour, minute, second);
	#}
	#public DateTime GetAsDateTime()
	#{
		#return new DateTime(year, month, day, hour, minute, second);
	#}
#}
#[System.Serializable]
#public class LogCommitReceived
#{
	#public string m_commitId;
	#public string m_author;
	#public string m_userMail;
	#public string m_label;
	#public int m_year;
	#public int m_month;
	#public int m_day;
	#public int m_hour;
	#public int m_minute;
	#public int m_second;
	#public int m_millisecond;
#
	#public void SetLabel(string text)
	#{
		#m_label = text;
	#}
#
	#public void SetCommitId(string id)
	#{
		#m_commitId = id;
#
	#}
	#public void SetAuthor(string name)
	#{
		#m_author = name;
	#}
	#public void SetMail(string mail)
	#{
		#m_userMail = mail;
	#}
	#public DateTime GetDate()
	#{
		#return new DateTime(m_year, m_month, m_day, m_hour, m_minute, m_second, m_millisecond);
	#}
#
#
	#public string GetAsOnliner()
	#{
		#return string.Format("{0}({1}): {2} -> {3}",
			#m_author, m_userMail,
			#GetDate().ToString("yyyy-MM-dd HH:mm"),
			#m_commitId);
	#}
#
	#public void SetDate(int year, int month, int day, int hour, int minute, int second, int millisecond)
	#{
		#m_year = year;
		#m_month = month;
		#m_day = day;
		#m_hour = hour;
		#m_minute = minute;
		#m_second = second;
		#m_millisecond = millisecond;
	#}
#
#
#}
#
#
#[System.Serializable]
#public class GitLink
#{
	#public string m_gitLink;
	#public bool IsLinkDefined() { return !string.IsNullOrWhiteSpace(m_gitLink); }
#}
#[System.Serializable]
#public class GitLinkOnDisk : GitLink
#{
	#public string m_projectDirectoryPath;
#
	#public GitLinkOnDisk(string directoryPath)
	#{
		#QuickGit.GetGitUrl(directoryPath,out m_gitLink);
		#this.m_projectDirectoryPath = directoryPath;
	#}
#
	#public void OpenFolder()
	#{
		#if (Directory.Exists(m_projectDirectoryPath))
			#Application.OpenURL(m_projectDirectoryPath);
	#}
	#public void OpenHost()
	#{
			#Application.OpenURL(m_gitLink);
	#}
	#public bool IsPathDefined() { return !string.IsNullOrWhiteSpace(m_projectDirectoryPath); }
#
	#public string GetDirectoryPath()
	#{
		#return m_projectDirectoryPath;
	#}
#
	#public bool IsInsideUnityProject() {
	   #return  QuickGit.IsGitInsideProject(m_projectDirectoryPath);
	#}
	#public bool IsOutsideUnityProject() {
		#return !IsInsideUnityProject();
	#}
#
	#public bool Exist()
	#{
		#return Directory.Exists(m_projectDirectoryPath) && Directory.Exists(m_projectDirectoryPath+"/.git");
	#}
#
	#public string GetUrl()
	#{
		#return m_gitLink;
	#}
#
	#public string GetName()
	#{
		#int indexOf = m_gitLink.LastIndexOf("/");
		#if (indexOf < 0)
			#indexOf = m_gitLink.LastIndexOf("\\");
		#if (indexOf < 0)
			#indexOf = 0;
		#return m_gitLink.Substring(indexOf).Replace(".git", "")
			#.Replace("/", "").Replace("\\", "");
	#}
#
	#public bool IsHosted()
	#{
		#return m_gitLink != null && m_gitLink.Length > 0;
	#}
#
	#public GitServer GetServerType()
	#{
		#return DownloadInfoFromGitServer.GetServerTypeOfPath(m_gitLink);
	#}
#
	#public bool HasUrl()
	#{
		#return IsHosted();
	#}
#
	#public string GetRelativeDirectoryPath()
	#{
	   #string up= Directory.GetCurrentDirectory().Replace("\\","/");
	   #string ap = m_projectDirectoryPath.Replace("\\", "/");
		#string result = ap.Replace(up, "");
		#if (result.Length>0 && 
			#(result[0] == '/' || result[0] == '\\') )
			#return result.Substring(1);
		#return result;
	#}
#
	#public string GetLastRevision()
	#{
		#bool found;
		#string value;
		#QuickGit.GetLastRevision(m_projectDirectoryPath, out found, out value);
		#return value;
	#}
	#public string GetLastRevision(out bool found)
	#{
		#string value;
		#QuickGit.GetLastRevision(m_projectDirectoryPath, out found, out value);
		#return value;
	#}
#}
#
#
#
#}
