class_name GitTerminalCommandBuilder
extends Node


static func append_git_init(out_commands: Array[String]) -> void:
	out_commands.append("git init")

static func append_git_status(out_commands: Array[String]) -> void:
	out_commands.append("git status")

static func append_git_add_all_files(out_commands: Array[String]) -> void:
	out_commands.append("git add -A")

static func append_git_commit(out_commands: Array[String], commit_message: String) -> void:
	out_commands.append("git commit -m \"" + commit_message + "\"")
	
static func append_git_push(out_commands: Array[String]) -> void:	
	out_commands.append("git push")

static func append_git_pull(out_commands: Array[String]) -> void:	
	out_commands.append("git pull")


static func append_git_clone(out_commands: Array[String], git_url: String, target_folder: String="") -> void:
	out_commands.append("git clone --recursive " + git_url + " " + target_folder)

static func append_git_add_safe_directory(out_commands: Array[String], directory_path: String) -> void:
	out_commands.append("git config --global --add safe.directory \"" + directory_path + "\"")

static func append_git_config_global_user_name(out_commands: Array[String], user_name: String) -> void:
	out_commands.append("git config --global user.name \"" + user_name + "\"")

static func append_git_config_global_user_email(out_commands: Array[String], user_email: String) -> void:
	out_commands.append("git config --global user.email \"" + user_email + "\"")

static func append_git_create_branch(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git branch " + branch_name)

static func append_git_checkout_branch(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git checkout " + branch_name)

static func append_git_switch_branch(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git switch " + branch_name)


static func apppend_git_fetch(out_commands: Array[String]) -> void:
	out_commands.append("git fetch")

static func append_get_git_remote_url(out_commands: Array[String]) -> void:
	out_commands.append("git config --get remote.origin.url")

static func append_git_log(out_commands: Array[String], max_count: int = 10) -> void:
	out_commands.append("git log -n " + str(max_count))

static func append_git_log_oneline(out_commands: Array[String], max_count: int = 10) -> void:
	out_commands.append("git log --oneline -n " + str(max_count))

static func append_git_log_pretty_format(out_commands: Array[String], format: String, max_count: int = 10) -> void:
	out_commands.append("git log --pretty=format:\"" + format + "\" -n " + str(max_count))

static func append_get_git_last_commit_id(out_commands: Array[String]) -> void:
	out_commands.append("git rev-parse HEAD")

static func append_get_git_branch(out_commands: Array[String]) -> void:
	out_commands.append("git branch")

static func append_get_tags(out_commands: Array[String]) -> void:
	out_commands.append("git tag")

static func append_git_tag_version_name(out_commands: Array[String],tag_version: String, tag_name: String) -> void:
	out_commands.append("git tag -a " + tag_version + " -m \"" + tag_name + "\"")

static func append_git_tag_version_with_date_yyyy_mm_dd(out_commands: Array[String], tag_name: String) -> void:
	var date = Time.get_date_dict_from_system()
	var tag_version = str(date.year) + "." + str(date.month) + "." + str(date.day) + "." + tag_name
	tag_version = tag_version.replace(" ", "_").replace(":", "_").replace("-", "_").replace(".", "_").replace("\\", "_")
	out_commands.append("git tag -a \"" + tag_version + "\" -m \"" + tag_name + "\"")

static func append_git_delete_tag(out_commands: Array[String], tag_version: String) -> void:
	out_commands.append("git tag -d " + tag_version)

static func append_git_submodule_update(out_commands: Array[String], init: bool = true, recursive: bool = true) -> void:
	out_commands.append("git submodule update" + (" --init" if init else "") + (" --recursive" if recursive else ""))

static func append_git_submodule_add(out_commands: Array[String], git_url: String, target_folder: String="") -> void:
	out_commands.append("git submodule add " + git_url + " " + target_folder)


static func append_git_merge(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git merge " + branch_name)


static func append_git_rebase(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git rebase " + branch_name)

static func append_git_reset_hard(out_commands: Array[String]) -> void:
	out_commands.append("git reset --hard")

static func append_git_reset_hard_to_commit(out_commands: Array[String], commit_id: String) -> void:
	out_commands.append("git reset --hard " + commit_id)

static func append_git_discard_changes(out_commands: Array[String]) -> void:
	out_commands.append("git checkout -- .")


static func append_git_push_origin_branch(out_commands: Array[String], branch_name: String) -> void:
	out_commands.append("git push origin " + branch_name)


static func append_git_conflict_keep_mine_all(out_commands: Array[String]) -> void:
	out_commands.append("git checkout --ours .")

static func append_git_conflict_keep_theirs_all(out_commands: Array[String]) -> void:
	out_commands.append("git checkout --theirs .")

static func append_git_conflict_keep_mine_file(out_commands: Array[String], file_path: String) -> void:
	out_commands.append("git checkout --ours \"" + file_path + "\"")

static func append_git_conflict_keep_theirs_file(out_commands: Array[String], file_path: String) -> void:
	out_commands.append("git checkout --theirs \"" + file_path + "\"")



static func append_git_blame(out_commands: Array[String], file_path: String) -> void:
	out_commands.append("git blame \"" + file_path + "\"")

static func append_git_show_commit(out_commands: Array[String], commit_id: String) -> void:
	out_commands.append("git show " + commit_id)

static func append_git_diff(out_commands: Array[String], commit_id_a: String, commit_id_b: String) -> void:
	out_commands.append("git diff " + commit_id_a + " " + commit_id_b)

static func append_git_submodule_status(out_commands: Array[String]) -> void:
	out_commands.append("git submodule status --recursive")

static func append_get_git_submodule_folders_path(out_commands: Array[String]) -> void:
	out_commands.append("git config --file .gitmodules --get-regexp path")

static func apppend_get_git_submodule_urls(out_commands: Array[String]) -> void:
	out_commands.append("git config --file .gitmodules --get-regexp url")

static func append_git_submodule_file(out_commands: Array[String]) -> void:
	out_commands.append("git show HEAD:.gitmodules")

static func append_git_file_text_from_relative_path(out_commands: Array[String], relative_path: String) -> void:
	out_commands.append("git show HEAD:\"" + relative_path + "\"")


static func append_git_commit_of_relative_file(out_commands: Array[String], relative_path: String) -> void:
	out_commands.append("git log -n 1 --pretty=format:\"%H\" -- \"" + relative_path + "\"")

static func append_git_commit_and_date_of_relative_file(out_commands: Array[String], relative_path: String) -> void:
	#out_commands.append("git log -n 1 --pretty=format:\"%ad\" -- \"" + relative_path + "\"")
	# ass yyyy_mm_dd_hh_mm_ss
	out_commands.append("git log -n 1 --pretty=format:\"%H:%ad\" --date=format:%Y_%m_%d_%H_%M_%S -- \"" + relative_path + "\"")





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
