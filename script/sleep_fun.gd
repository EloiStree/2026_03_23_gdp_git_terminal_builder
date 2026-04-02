extends  Node

@export var runner:GitTerminalCommandRunnerExe
@export var a_git_project_folder_path: String


func _ready() -> void:
	var f = a_git_project_folder_path
	var fp =GitTerminalStaticFunc.get_git_root_folder_from_parent(a_git_project_folder_path) 
	#runner.open_exe_task_manager()
	#runner.open_exe_vscode()
	var folder_exists = GitTerminalStaticFunc.is_folder_exists(a_git_project_folder_path)
	print("Folder exists: ", folder_exists)
	GitTerminalStaticFunc.update_git_keep_in_folder_recusrive(a_git_project_folder_path)
	#In Godot Engine, basic types like int, String, float
	var cmd:Array[String]= []
	GitTerminalCommandBuilder.append_get_git_remote_url(cmd)
	GitTerminalCommandBuilder.append_git_status(cmd)
	GitTerminalCommandBuilder.append_git_tag_version_with_date_yyyy_mm_dd(cmd, "Hello")
	GitTerminalCommandBuilder.append_get_tags(cmd)
	print(cmd)
	
	for c in cmd:
		var result := runner.run_exe_cmd_and_get_output(f,c)
		print("SEND:\n", c, "\nRECEIVED:\n", result.output)

	print("HAS GITIGNORE:",GitTerminalStaticFunc.is_folder_have_git_ignore(a_git_project_folder_path))
	print("HAS .GIT:",GitTerminalStaticFunc.is_folder_have_git_root(a_git_project_folder_path))	
	print("PARENT:",GitTerminalStaticFunc.get_parent_of_folder(a_git_project_folder_path))
	print("GIT IN PARENT:",GitTerminalStaticFunc.get_git_root_folder_from_parent(a_git_project_folder_path))
	
	cmd.clear()
	#GitTerminalCommandBuilder.append_git_submodule_file(cmd)
	GitTerminalCommandBuilder.append_git_commit_and_date_of_relative_file(cmd, "README.md")
	for c in cmd:
		var result := runner.run_exe_cmd_and_get_output(fp,c)
		print("SEND:\n", c, "\nRECEIVED:\n", result.output)
	
	#var files = GitTerminalStaticFunc.get_all_files_bigger_that_mega_bytes_recursive(a_git_project_folder_path, 1)
	#print(files)
	# GitTerminalCommandRunnerExe.open_exe_folder_in_explorer(a_git_project_folder_path)
	
	
	
