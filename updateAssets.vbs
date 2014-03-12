On Error Resume Next
	dim fso, write, start, writeTo

	' File exceptions array
	dim exceptions(3)
	exceptions(0) = "assets/levels/ogmo.oep"
	
	' File extension exceptions
	dim ext_exceptions(2)
	ext_exceptions(0) = "bfxrsound"
	ext_exceptions(1) = "wav"
	
	' Where to read from, where to write to
	start = "assets"
	writeTo = "src/Assets.as"

	Set fso = CreateObject("Scripting.FileSystemObject")
	Set write = fso.CreateTextFile(writeTo, True)

	' Begin file
	write.WriteLine("package")
	write.WriteLine("{")
	write.WriteLine("	public class Assets")
	write.WriteLine("	{")

	' Read files
	readFolder("")

	' Close
	write.WriteLine("	}")
	write.WriteLine("}")

	write.Close

	Function readFolder(name)
		Dim folder, files, folders, list, count, listName, className, extension, fontName
		Set folder = fso.GetFolder(start & "/" & name)

		' Clean the list name
		listName = UCase(name)
		listName = Replace(listName, "/", "_")
		listName = Replace(listName, "-", "_")
		listName = Replace(listName, " ", "")
		
		If listName = "" Then
			listName = "PRIMARY"
		End If
		
		list = "		public static const " & listName & ":Array = ["

		count = 0

		' For every file ...
		For each file In folder.Files

			' Clean the file name
			className = Left(file.Name, Len(file.Name) - 4)
			className = name & "_" & className
			className = Replace(className, "/", "_")
			className = Replace(className, " ", "")
			className = Replace(className, "-", "_")
			className = UCase(className)
			fontName = Replace(className, "_", "")

			' get the extension
			extension = Right(file.Name, len(file.Name) - InStrRev(file.Name,".",len(file.Name)))

			Dim link
			If name = "" Then
				link = start
			Else
				link = start & "/" & name
			End If
			
			' Find out if it's an exception
			Dim ignore
			ignore = False
			For Each present In exceptions
				If link & "/" & file.Name = present Then
					ignore = True
				End If
			Next
			
			' Find out if it's a extension we don't link
			If ignore = False Then
				For Each present In ext_exceptions
					If extension = present Then
						ignore = True
					End If
				Next
			End If
			
			' If it's not an exception, then load it
			If ignore = False Then
			
				' Add it to the list (array of files from this folder)
				If count = 0 Then
					list = list & className
				Else
					list = list & ", " & className
				End If
				
				' Write this to the file
				If extension = "oel" Or extension = "xml" Or extension = "wav" Then
					write.WriteLine("		[Embed(source='../" & link & "/" & file.Name & "', mimeType='application/octet-stream')] public static const " & className & ":Class;")
				ElseIf extension = "ttf" Then
					write.WriteLine("		[Embed(source='../" & link & "/" & file.Name & "', embedAsCFF='false', fontFamily = '" & fontName & "')] public static const " & className & ":Class;")
				ElseIf extension = "pbj" Then
					write.WriteLine("		[Embed(source='../" & link & "/" & file.Name & "', mimeType='application/octet-stream')]  public static var " & className & ":Class;")
				Else
					write.WriteLine("		[Embed(source='../" & link & "/" & file.Name & "')] public static const " & className & ":Class;")
				End If
				count = count + 1
			
			End If
		Next

		' Write the list of files from the folder, if any files exist
		If count > 1 Then
			list = list & "];"
			write.WriteLine(list)
		End If

		' Find all the subfolders, and read them
		For each subfolder in folder.SubFolders
			write.WriteLine("")
			write.WriteLine("		/* --- " & subfolder.Name & " --- */")

			' only add a / if the previous folder exists (not the root folder)
			If name = "" Then
				readFolder(subfolder.Name)
			Else
				readFolder(name&"/"&subfolder.Name)
			End If
		Next

	End Function