DGVTS00 ;7DELTA/KDC - VTS Stand alone Option routine ;07-MAR-2012
 ;;5.3;REGISTRATION;**853**;07-MAR-2012;Build 104
 Q
 ; This routine was built for the Veterans Transportation Service (VTS) project.
 ; A flat file is created from the RouteMatch database containing its Veteran population. 
 ; The flat file will contain Veteran name, address and phone number. The routine reads 
 ; a record from the flat file and tries to find the corresponding Veteran in VistA. 
 ; A match is only made if all fields (name, city, state, zip code and phone number) match.
 ; Otherwise the record that was read in is written out to an exception report file 
 ; containing Veteran's for whom the process could not determine a match. If a match 
 ; is found then the ICN associated with the Veteran is appended to the record that 
 ; was read in and written out to the output file. The output file will be sent to 
 ; RouteMatch to be loaded into their database.
 ; 
 Q
 ;
 ; Entry point for the process
 ; A call to allow for the variable ZEOF to catch End of File
 ;
EN ;
 N DLM,STOP,INPUTFILE,REC,FOUND,ICN,IEN,NAME
 N RMNAME,FNAME,LNAME,MI,PATADD,FLG,CITY,ZIP
 N STATE,PHONE,DFN,RMREC,DA,DIE,DR,IO,STATION
 N ICNFILE,REPORTFILE,DIR,INPUT,POP,ADD1,ADD2
 ; Define the delimiter characters
 S DLM=","
 ;
 ; Get Primary Station Number from File 389.9 - Station Number (Time Sensitive)
 ;    Node 0 Piece 4   ^VA(389.9
 ; SITE^VASITE returns the Station Number in the third argument
 S STATION=+$P($$SITE^VASITE(),"^",3)
 ;
 ;
 ; Call to open the file
 ; If any of the files could not be opened the process stops
 ;
 S STOP=0
 D OPENFILE Q:STOP
 ;
 ; Read records from input file
 ; Extract fields from the record
 ; Compare the VistA patient information to the data in the fields
 ; from the input record
LOOP ;
 USE INPUTFILE
 READ REC:5 I $$STATUS^%ZISH G CL
 I REC=$C(13,10) G LOOP
 D EXDATA
 D COMP
 G LOOP
 ; Compare information
COMP ;
 ; Initialize variables
 ; If variable FOUND is set than we have a successful match
 ; Variable IEN is used to loop through the patient file for a set
 ; Veteran name
 ; (there can be several patients with the same name)
 ; Variable ICN will be populated with the matching Veterans ICN
 ;
 S FOUND=0
 S IEN=0
 S ICN=""
 S RMNAME=LNAME_","_FNAME
 S:MI]"" RMNAME=RMNAME_" "_MI
 S NAME=RMNAME
 ;
 ; If name field is missing skip compare and go straight to writing
 ; data to a report file
 ;
 I NAME']"" G CPOUT
 ;
 ; Loop through patient name index to try and find the matching
 ; Veteran
 ; with the given name or a match was found
CP1 S IEN=$O(^DPT("B",NAME,IEN)) G:FOUND>1 CPOUT G:'IEN CP
 ;
 ; Set variable PATADD with the patient's address information
 ;
 S PATADD=$$UP($G(^DPT(IEN,.11)))
 ;
 ; Variable FLG is used to indicate if data is a match or not
 ;
 S FLG=0
 ;
 I $P(PATADD,U,4)=CITY,$P(PATADD,U,6)=ZIP S FLG=1
 ;
 ; If data did not match loop back to see if there are more patients
 ; with the given name to check
 ;
 ; Reset FLG and compare STATE field
 ;
 I FLG=0 G CP1
 S FLG=0
 I $P(PATADD,U,5)]"",STATE=$P($G(^DIC(5,$P(PATADD,U,5),0)),U,2) S FLG=1
 I STATE="",$P(PATADD,U,5)="" S FLG=1
 ;
 ; If data did not match loop back to see if there are more patients
 ; with the given name to check
 ;
 I FLG=0 G CP1
 S FLG=0
 ;
 ; compare components of the phone number
 ;
 ; If phone number matches set variable FOUND and ICN
 I $TR(PHONE,"()-. :")=$TR($P($G(^DPT(IEN,.13)),U),"()-. :") D 
 .  S FOUND=FOUND+1
 .  ;S ICN=$P($G(^DPT(IEN,"MPI")),U)
 .  S DFN=IEN
 .  S ICN=+($$GETICN^MPIF001(DFN))
 ; 
 ; If MPIF001 returns -1 error - patient not in database
 ; Set FOUND to indicate Veteran not found and place
 ; entry on Exception report
 ;
 I +ICN=-1 S FOUND=0 G CPOUT
 ;
 G CP1
 ;
 ; Look to see if there are additional patients to examine
 ;
CP S NAME=$O(^DPT("B",NAME)) G:NAME="" CPOUT
 ;
 ; if there was no middle initial then the name must match exactly
 ;
 I MI="",NAME'=RMNAME G CPOUT
 I MI]"",NAME'[RMNAME G CPOUT
 ;
 ; if there was a middle initial then keep looking as long as the
 ; VistA patient name totaly contains the name from RouteMatch
 ;
 G CP1
 ;
 ; Determine which file to write information in based on the value
 ; of the variable FOUND
CPOUT ;
 I FOUND=0!(FOUND>1) U REPORTFILE W REC,! Q
 ; If match was found then build record with additional data elements
 ; to be returned
 ;
 ; Record format 
 ; 1. DFN
 ; 2. Last 4 of SSN
 ; 3. Last Name
 ; 4. First Name
 ; 5. Middle Initial
 ; 6. Address Line 1
 ; 7. Address Line 2
 ; 8. City
 ; 9. State
 ; 10. Zip
 ; 11. Phone
 ; 12. ICN
 ;
 S RMREC=""
 S $P(RMREC,",")=$$TRIM(DFN)
 S $P(RMREC,",",2)=$E($P($G(^DPT(DFN,0)),U,9),6,9)
 S $P(RMREC,",",3)=$$TRIM(LNAME)
 S $P(RMREC,",",4)=$$TRIM(FNAME)
 S $P(RMREC,",",5)=$$TRIM(MI)
 S $P(RMREC,",",6)=$$TRIM(ADD1)
 S $P(RMREC,",",7)=$$TRIM(ADD2)
 S $P(RMREC,",",8)=$$TRIM(CITY)
 S $P(RMREC,",",9)=$$TRIM(STATE)
 S $P(RMREC,",",10)=$$TRIM(ZIP)
 S PHONE=$TR(PHONE,"()-. :")
 I $L(PHONE)=10 S PHONE="("_$E(PHONE,1,3)_")"_$E(PHONE,4,6)_"-"_$E(PHONE,7,10)
 S $P(RMREC,",",11)=$$TRIM(PHONE)
 S $P(RMREC,",",12)=$$TRIM(ICN)
 ;
 U ICNFILE W RMREC,!
 ;
 ; Match found - Set the Patient Flag indicating
 ; patient is part of the VTS program
 ;
 L +^DPT(DFN):5 I '$T QUIT
 S DIE=2,DA=DFN,DR="3000///1" D ^DIE
 L -^DPT(DFN)
 ;
 QUIT
 ;
 ; Open files
 ; Open the input file and the two output files (the exception report
 ; and the ICN included files
 ; If the process could not open the files write information to the
 ; screen and stop the process.
 ;
OPENFILE ;
 R !,"Enter the directory where files are located: ",DIR:60,!
 I DIR="" W !,"No directory supplied, process stopped" S STOP=1 Q
 R !,"Enter input file name: ",INPUT:60,!!
 I INPUT="" W !,"No input file name, process stopped" S STOP=1 Q
 ; Opening input file
 ;
 ;
 D OPEN^%ZISH("",DIR,INPUT,"R")
 I POP D
 . W !,"Unable to open input file: "_DIR_INPUT,!,"Process stopped"
 . S STOP=1
 ;
 I STOP=1 Q
 S INPUTFILE=IO
 ;
 ; Opening ICN included file
 ;
 ;
 D OPEN^%ZISH("",DIR,STATION_"_ICNOUTPUT.CSV","WN")
 I POP D
 .  W !,"Unable to open output file: "_DIR_STATION_"_ICNOUTPUT.CSV",!,"Process stopped"
 .  S IO=INPUTFILE
 .  D CLOSE^%ZISH(INPUTFILE) S STOP=1 Q
 ;
 I STOP=1 Q
 S ICNFILE=IO
 ;
 ; Opening the exception exception report file
 ;
 ;
 D OPEN^%ZISH("",DIR,STATION_"_EXCEPTION.CSV","WN")
 I POP D
 .  W !,"Unable to open report file: "_DIR_STATION_"_EXCEPTION.CSV",!,"Process stopped"
 .  S IO=INPUTFILE
 .  D CLOSE^%ZISH(INPUTFILE)
 .  S IO=ICNFILE
 .  D CLOSE^%ZISH(ICNFILE)
 .  S STOP=1
 S REPORTFILE=IO
 Q
 ;
 ; Extract fields from the input record
 ; variable REC contains the input record information
 ; layout of record is
 ;
 ;Last Name
 ;First Name
 ;Middle Initial
 ;Address Line 1
 ;Address Line 2
 ;City
 ;State
 ;ZIP
 ;Phone Number
EXDATA ;
 S LNAME=$$TRIM($$UP($P(REC,DLM)))
 S FNAME=$$TRIM($$UP($P(REC,DLM,2)))
 S MI=$$TRIM($$UP($P(REC,DLM,3)))
 S ADD1=$$UP($P(REC,DLM,4))
 S ADD2=$$UP($P(REC,DLM,5))
 S CITY=$$TRIM($$UP($P(REC,DLM,6)))
 S STATE=$$TRIM($$UP($P(REC,DLM,7)))
 S ZIP=$$TRIM($$UP($P(REC,DLM,8)))
 S PHONE=$$UP($P(REC,DLM,9))
 Q
 ; Change lowercase to uppercase
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
 ;Remove leading and trailing spaces
TRIM(DATA) ;
 N I,J
 F I=1:1 Q:$E(DATA,I)'=" "
 F J=$L(DATA):-1 Q:$E(DATA,J)'=" "
 Q $E(DATA,I,J)
 ;
 ; Close all files and write that the process has completed
 ;
CL ;
 S IO=ICNFILE
 D CLOSE^%ZISH(ICNFILE)
 S IO=REPORTFILE
 D CLOSE^%ZISH(REPORTFILE)
 S IO=INPUTFILE
 D CLOSE^%ZISH(INPUTFILE)
 U 0
 WRITE !,"Process complete",!
 QUIT 
