PXRMTXIH ;SLC/PKR - Taxonomy import help. ;04/21/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
HELP ;Extended help for import.
 N DDS,DIR0,DONE,IND,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 S DDS=1,DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3,99)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Taxonomy Import Help")
 S VALMBCK="R"
 Q
 ;
 ;==========================================
HTEXT ;Import help text.
 ;;Codes can be imported from a CSV (comma-separated value) file or from one
 ;;taxonomy into another.
 ;;
 ;;  HF - use this action when the CSV file has been saved as a host file.
 ;;  PA - use this action to paste in the CSV file.
 ;; TAX - use this action to select another taxonomy to import codes from. Once
 ;;       selected, you can import all the codes or selected sets of codes.
 ;; WEB - use this action to import a CSV file from a web site. You will need 
 ;;       the full url of the CSV file.
 ;;
 ;;Creating a CSV file
 ;;Each row of the CSV file should have the following format:
 ;;Column 1 - term/code
 ;;Column 2 - three-character coding system abbreviation
 ;;
 ;;The list of codes for the term/code and coding system combination starts at
 ;;column 3. There can be as many subsequent columns as necessary. For example,
 ;;if there were four codes for the term/code coding system combination, then:
 ;;
 ;;Column 3 - first code
 ;;Column 4 - second code
 ;;Column 5 - third code
 ;;Column 6 - fourth code
 ;;
 ;;An easy way to create a CSV file s to first create a spreadsheet where the
 ;;columns are as described above. When the spreadsheet is complete, use SAVE AS
 ;;to save it to a CSV file. You can also create a CSV file directly using a text
 ;;editor.
 ;;
 ;;Host File
 ;;Once you have created the CSV file, you will probably need help from IRM to
 ;;move the file to a VistA-accessible directory. The format of this will
 ;;depend on the type of operating system on the server. The path includes the
 ;;device and directory. Your IRM person should be able to give you this. Once
 ;;you have entered the path, all files with a .CSV extension will be listed.
 ;;Type in the name of the file you want to import and press <Enter>.
 ;;
 ;;Pasting
 ;;Open the CSV file on your computer as a text file, using a text editor such as
 ;;Notepad. Do not open it as a spreadsheet. Highlight all the rows you want to
 ;;import and copy them. Go to your VistA session and select the PA action. At the
 ;;prompt "Paste the CSV file now, press <ENTER> to finish.", paste what has been
 ;;copied within 10 seconds. The import will complete; you will then need to save
 ;;the imported codes.
 ;;
 ;;Web
 ;;This action will import a CSV file from a web site. You must know the exact
 ;;url. NOTE: The only protocol currently supported is http; https will not work.
 ;;Enter the url at the prompt and then press <Enter>.
 ;;
 ;;TAX
 ;;This option is used to import codes from an existing taxonomy into another
 ;;existing taxonomy. The receiving taxonomy may already have codes or may be a
 ;;shell of a taxonomy (contains no codes). After selecting the TAX action, you
 ;;will see the prompt "Select a taxonomy or taxonomies to import from." a
 ;;List Manager display will then open, listing all the taxonomies on your system.
 ;;You can select one or more taxonomies to import from by typing in a
 ;;comma-separated list or a range. Once the selection has been made, choose the
 ;;Done (Quit) action. You will then be prompted to choose either ALL or
 ;;SEL(ected) codes. If you choose SEL, each Term/Code Coding system pair in the
 ;;taxonomies being imported from will be displayed and you can choose whether or
 ;;not to import that set of codes.
 ;;
 ;;**End Text**
 Q
 ;
