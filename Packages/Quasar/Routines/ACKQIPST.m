ACKQIPST ;HCIOFO/BH-Version 3 Post Installation routine ;  04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 N ACKTEST S ACKTEST=$$GET1^DIQ(509850.8,1,.1,"I")
 I ACKTEST="S"!(ACKTEST="D") D  Q
 . S ACKTXT(1)="Installation Routine has already been run."
 . S ACKTXT(2)="Therefore will only attempt to add The PIMS 'Clinic Workload' report option"
 . S ACKTXT(3)="to the Quasar Reports menu. Will not update CDR Report parameter."
 . S ACKTXT(4)=" " D MES^XPDUTL(.ACKTXT) K ACKTXT
 . S ACKCHK=$$NEWCP^XPDUTL("POST1","OPTN^ACKQIPST")
 . Q  ; Return to KIDS & let KIDS run the checkpoint.
 ;
 K ^TMP("ACKQIPST","INSTALLV3")
 ;  Setup chkpoints for KIDS.
 ;
 N ACKCHK
 S ACKCHK=$$NEWCP^XPDUTL("POST1","REPORT^ACKQIPST")
 ; Updte Params file with input for CDR report. Virgin 
 ; site -  just set up site level on Params file,set Interface to PCE 
 ; & CDR param values
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST2","MAIN^ACKQIPST")
 ; Update Visit file with Appmnt Time, Div & Proc Vol. Also 
 ; store Divs and Clins for later update into site params file.
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST21")
 ; Keep track of visit date subscript of Visit file B X Ref
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST22")
 ; Keep track of visit IEN subscript of Visit file B X Ref
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST24")
 ; Keep track of secs within Apnt Time Gen.
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST25")
 ; Keep track of mins within Appt Time Gen.
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST26")
 ; Keep track of hrs within Appt Time Gen.
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST3","PARAMSD^ACKQIPST")
 ; Update Div Values used within the above visits onto the site 
 ; params file 
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST31")
 ; Keep track of Divs within the Temp global of Divs & Clins
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST4","PARAMSC^ACKQIPST")
 ; Update Clin Vals used within the above visits onto the site 
 ; params file
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST41")
 ; Keep track of Divs within the Temp global of Divs & Clins
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST42")
 ; Keep track of Clins within the Temp global of Divs & Clins
 ;
 S ACKCHK=$$NEWCP^XPDUTL("POST5","OPTN^ACKQIPST")
 S ACKCHK=$$NEWCP^XPDUTL("POST6","STAFF^ACKQIPS1")
 ;
 Q  ;Return to KIDS & let KIDS run the checkpoints.
 ;
REPORT ; Virgin Install : set up the .01 node
 ; Update CDR Report param
 ;
 S ^TMP("ACKQIPST","SKIP")="0"
 I $$GET1^DIQ(509850.8,1,.01)="" D
 . S ^TMP("ACKQIPST","SKIP")="1"  ; Keep note of Skip
 . S DIC="^ACK(509850.8,",DIC(0)="L",DLAYGO=509850.8,ACKLAYGO="",DINUM=1
 . S X="1" D FILE^DICN   ;  Do a FM call to set up Site .01 level
 . ;
 . D BMES^XPDUTL("Virgin Install - Site level being created on A&SP Site Parameters file.")
 . ;
 . K ACKARR
 . S ACKARR(509850.8,1_",",2)="0" D FILE^DIE("K","ACKARR")
 . D BMES^XPDUTL("Interface to PCE Parameter set to 'NO'.")
 . K DA,DIK,ACKARR
 ;
 I '$D(XPDQUES("POS1")) D
 . D BMES^XPDUTL("CDR Report parameter not entered - Install will use default value of 'Site'.")
 . S XPDQUES("POS1")="S" Q
 ;
 N ACKARR
 S ACKARR(509850.8,1_",",.1)=XPDQUES("POS1") D FILE^DIE("K","ACKARR")
 D BMES^XPDUTL("CDR Report Parameter updated.")
 K DA,DIK
 Q
 ;
MAIN I ^TMP("ACKQIPST","SKIP") Q  ;  Virgin Site
 ;
 ; Loop thru the B X ref
 ; Clin val is used to get a Div value
 ; A unique time is gererated
 ; Updates Procs new Vol field with 1
 ; Appt. Time & the vols are updated within one FM call
 ; Divn is updated last
 ; All the above fields run X ref that sets the LAST EDITED IN 
 ; QUASAR field to NOW
 ;
 N ACKTXT,ACKAY1,ACKAY2,ACKAY3,ACKAY7,ACKAY8,ACKAY9,ACKQSEC,ACKARR1
 K TARGET
 S POST21=+$$PARCP^XPDUTL("POST21")  ;  VISIT DATE
 S POST22=+$$PARCP^XPDUTL("POST22")  ;  VISIT IEN
 S ACKS=+$$PARCP^XPDUTL("POST24")
 S ACKM=+$$PARCP^XPDUTL("POST25")
 S ACKH=+$$PARCP^XPDUTL("POST26")
 ;
 S ACKTXT(1)=" "
 S ACKTXT(2)="Looping through A&SP Clinic Visit File updating all visits with an Appnt."
 S ACKTXT(3)="Time and Division value & all visits Procedures with a Volume value."
 S ACKTXT(4)=" " D MES^XPDUTL(.ACKTXT) K ACKTXT
 ;
 F  S POST21=$O(^ACK(509850.6,"B",POST21)) Q:POST21=""  D
 . F  S POST22=$O(^ACK(509850.6,"B",POST21,POST22)) Q:POST22=""  D
 . .;
 . . S ACKQSEC=$$GET1^DIQ(509850.6,POST22_",",.25,"I")
 . . I ACKQSEC'="" D
 . . . S ACKARR1(509850.66,"+1,"_POST22_",",.01)=ACKQSEC
 . . . D UPDATE^DIE("","ACKARR1","","")
 . .;
 . . S (ACKDIV,ACKCLIN)=""
 . .;  Derive Div from clinic
 . . S ACKCLIN=$P($G(^ACK(509850.6,POST22,0)),U,6)
 . . I ACKCLIN'="" S ACKDIV=$$GET1^DIQ(44,ACKCLIN_",",3.5,"I")
 . .;
 . .;  Keep a list of all Divs with their Clins
 . . I ACKCLIN'="",ACKDIV'="" S ^TMP("ACKQIPST","INSTALLV3",ACKDIV,ACKCLIN)=""
 . .;---Generate Unique Appnt Time--
 . . I ACKS=""!(ACKM="")!(ACKH="") S (ACKS,ACKM,ACKH)=0
 . . I ACKS=60 S ACKS="0" S ACKM=+ACKM+1
 . . I $L(ACKS)=1 S ACKS="0"_ACKS
 . . S ACKTIME=ACKS
 . . S ACKS=+ACKS+1
 . . ;
 . . I ACKM=60 S ACKM=0 S ACKH=+ACKH+1
 . . I $L(ACKM)=1 S ACKM="0"_ACKM
 . . ;
 . . I ACKH=24 S ACKH="0"
 . . I $L(ACKH)=1 S ACKH="0"_ACKH
 . . S ACKTME="."_ACKH_ACKM_ACKTIME
 . . ;
 . . S AKAY7=+$$UPCP^XPDUTL("POST24",ACKS)
 . . S ACKAY8=+$$UPCP^XPDUTL("POST25",ACKM)
 . . S ACKAY9=+$$UPCP^XPDUTL("POST26",ACKH)
 . .;---End of Appnt. Time Processing--
 . . K ACKARR,TARGET,ERRMSG
 . .;  Do FM LIST to get all procs within the visit
 . . D LIST^DIC(509850.61,","_POST22_",",".01","I","*","","","","","","TARGET","ERRMSG")
 . . S POST23=""   ;Initalise Proc IEN
 . . F  S POST23=$O(TARGET("DILIST",2,POST23)) Q:POST23=""  D
 . . .; Create an update array entry for each proc in the visit
 . . . S ACKARR(509850.61,TARGET("DILIST",2,POST23)_","_POST22_",",.03)="1"
 . .;
 . .;  Set update array with Appnt. Time
 . . S ACKARR(509850.6,POST22_",",55)=ACKTME
 . . D FILE^DIE("K","ACKARR")   ;Run FM to update time & vols
 . .;
 . . K ACKARR  ;Kill - Update vals have be updated onto visit file
 . .;
 . .;  Set update array with Derived Div.
 . . S ACKARR(509850.6,POST22_",",60)=ACKDIV
 . . D FILE^DIE("K","ACKARR")
 . . K ACKARR
 . . S ACKAY1=+$$UPCP^XPDUTL("POST22",POST22)
 . . Q
 . S ACKAY2=+$$UPCP^XPDUTL("POST21",POST21)
 . Q
 ;
 D BMES^XPDUTL("Update of A&SP Clinic Visit records Complete.")
 D BMES^XPDUTL("Temporary file of Clinics and Divisions Created.")
 Q
 ;
PARAMSD ; Update site param file
 I ^TMP("ACKQIPST","SKIP") Q  ;Virgin Site
 ;
 N ACKAY4
 ;
 ; Get Use Local Clin Nos, Use C&P and Bypass Audio values from
 ; Site level of Site Params file
 ;
 D BMES^XPDUTL("Commencing update of the A&SP Site Parameters file.")
 ;
 D GETS^DIQ(509850.8,1,".05;.07;.08","I","ACK","ERRMSG")
 ;
 S ACKLCN=$G(ACK(509850.8,"1,",.05,"I"))
 S ACKCNP=$G(ACK(509850.8,"1,",.07,"I"))
 S ACKBAU=$G(ACK(509850.8,"1,",.08,"I"))
 ;
 ; Loop thru Div. level of temp. file
 ;      
 D BMES^XPDUTL("Looping through Division Level of the Temporary file creating new")
 D BMES^XPDUTL("Division entries on the A&SP Site Parameters file.")
 ;
 S POST31=+$$PARCP^XPDUTL("POST31")
 F  S POST31=$O(^TMP("ACKQIPST","INSTALLV3",POST31)) Q:POST31=""  D
 . S ACKAY4=+$$UPCP^XPDUTL("POST31",POST31)
 .; For each Div. Set a new Div. level entry in Site params
 .;
 . S DIC="^ACK(509850.8,"_1_",2,"
 . S DIC(0)="L"
 . S DIC("P")="509850.83P"
 . S DA=POST31
 . S DA(1)=1
 . S X=POST31
 . S DINUM=POST31
 . D FILE^DICN K DIC,DA
 .;  
 .; Set following vals into new div. level of site params file
 .;
 . K ACKARR
 . S ACKARR(509850.83,POST31_",1,",.02)="I"
 . S ACKARR(509850.83,POST31_",1,",.03)="0"
 . S ACKARR(509850.83,POST31_",1,",.04)=ACKLCN
 . S ACKARR(509850.83,POST31_",1,",.06)=ACKCNP
 . S ACKARR(509850.83,POST31_",1,",.07)=ACKBAU
 .;
 . D FILE^DIE("K","ACKARR")
 . K ACKARR
 Q
 ;
PARAMSC ; Loop thru Clins in temp file & add them to the 
 ; relevant Divs.
 I ^TMP("ACKQIPST","SKIP") Q  ;Virgin Site
 ;
 N ACKAY5,ACKAY6
 S POST41=+$$PARCP^XPDUTL("POST41")
 S POST42=+$$PARCP^XPDUTL("POST42")
 ;
 D BMES^XPDUTL("Looping through Clinic Level of the Temporary file creating new Clinic")
 D BMES^XPDUTL("entries within the Divisions.")
 ;
 F  S POST41=$O(^TMP("ACKQIPST","INSTALLV3",POST41)) Q:POST41=""  D
 . I '$D(^ACK(509850.8,1,2,POST41,0)) D BMES^XPDUTL("Error Setting up Division - "_$$GET1^DIQ(40.8,POST41,.01)) Q
 . F  S POST42=$O(^TMP("ACKQIPST","INSTALLV3",POST41,POST42)) Q:POST42=""  D
 . . S ACKAY5=+$$UPCP^XPDUTL("POST42",POST42)
 . .;  Set each clin into the Clin multiple within the Div.
 . .;  level of the site params file
 . .;  If first time thru create clin level
 . .;
 . . S DIC="^ACK(509850.8,"_1_",2,"_POST41_",1,"
 . . S DIC(0)="L"
 . . S DIC("P")="509850.831P"
 . . S DA=POST42
 . . S DA(1)=POST41
 . . S DA(2)=1
 . . S X=POST42
 . . S DINUM=POST42
 . . D FILE^DICN K DIC,DA
 . S ACKAY6=+$$UPCP^XPDUTL("POST41",POST41)
 ;
 D BMES^XPDUTL("Clinic update complete.")
 ;
 ; Set PCE Interface param to False
 K ACKARR
 S ACKARR(509850.8,1_",",2)="0" D FILE^DIE("K","ACKARR")
 D BMES^XPDUTL("Interface to PCE Parameter set to False.")
 K DA,DIK
 ;
 K ^TMP("ACKQIPST","INSTALLV3")  ;  Kill temp Div/Clin file
 D BMES^XPDUTL("Site Parameters file Update complete.")
 Q
 ;
OPTN ; Place the SDCLINIC WORKLOAD option on menu.
 S X=$$ADD^XPDMENU("ACKQAS REPORTS","SDCLINIC WORKLOAD","",25)
 I X D BMES^XPDUTL("The PIMS 'Clinic Workload' report option"),MES^XPDUTL("has been added to the QUASAR 'Reports Menu.'")
 I 'X D BMES^XPDUTL("Sorry. I was unable to place the PIMS 'Clinic Workload'"),MES^XPDUTL("report option on the QUASAR 'Reports Menu.'")
 K X
 Q
 ;
