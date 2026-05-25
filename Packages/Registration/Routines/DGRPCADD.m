DGRPCADD ;ALB/MRL,BAJ,TDM,JAM,ARF,JAM - REGISTRATION SCREEN 1.1/CONFIDENTIAL ADDRESS INFORMATION ;19 Jul 2017  3:05 PM
 ;;5.3;Registration;**489,624,688,754,887,941,1056,1143**;Aug 13, 1993;Build 36
 ;
 ;;**688 BAJ Jan 17,2006 Modifications to support Foreign addresses
 ;;**941 JAM Apr 18,2017 Reformat of screen 1.1 - new field layouts
 ;
 N DGA,DGA1,DGA2,DGRP,DGAD,DGCAN,DGRPS,DGRPW,Z,Z1,DGZ,DGX,DGACT,DGCAT,DGI,DGTYP,DGTYPNAM,DGXX,CNT,DGBEG,DGEND,X,Y,I,I1
 S DGRPS=1.1 D H^DGRPU
 ;
 ; DG*5.3*1143 - If not already set, set flag for Real-time address update active or inactive
 ; If RTA is active, initialize the variables used for editing in screen 1.1
 ; DGRTAHOLD is the RTA Hold flag - used by the editing routines to determine if changes to the fields are to be held until filing in a batch  - set to 1
 ; DGADDEDIT(group#) to flag when an edit has happened in a group
 ; DGADDGRP1, DGADDGRP2, DGADDGRP3, DGADDGRP4, DGADDGRP5 are arrays that contain the edit data for each group on screen 1.1
 ; These variables are de-scoped in DGRPP when the user leaves screen 1.1
 I +$G(DGRTAON)=0 N DGRTAON S DGRTAON=$$ISRTAUON^DGRTAUPD() I DGRTAON=1 N DGRTAHOLD,DGADDEDIT,DGADDGRP1,DGADDGRP2,DGADDGRP3,DGADDGRP4,DGADDGRP5 S DGRTAHOLD=1
 ;
 W ! S Z=1,DGRPW=0 D WW^DGRPV W " Residential Address: " S Z=" ",Z1=15  ;DG*5.3*1056 - changed Z1 from 17 to 15
 ;DG*5.3*1056 removed Permanent from the following address label
 D WW1^DGRPV S Z=2,DGRPW=0 D WW^DGRPV W " Mailing Address: "
 I '$D(DGRP(.11)) D
 . F I=.11,.121,.122,.13,.115,.141 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 ;F I=.11,.121,.122,.13,.115,.141 S DGRP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 ;S DGAD=.11,(DGA1,DGA2)=1 D A^DGRPU I $P(DGRP(.121),"^",9)="Y" S DGAD=.121,DGA1=1,DGA2=2 D A^DGRPU
 ;
 ; DG*5.3*1143 - the data to be displayed on the screen is in DGRP array which was just loaded from the ^DPT global
 ;  If RTA Active flag is set, the call below will overwrite that array with data in the local arrays that have been created from user edits.
 ;  That data is to be displayed until the user saves or discards the changes.
 I $G(DGRTAON)=1 D LOADLOCAL
 ;
 S DGAD=.115,(DGA1,DGA2)=1 D AL^DGRPU(35) S DGAD=.11,DGA1=1,DGA2=2 D AL^DGRPU(35)
 W !?4
 S Z1=40,Z=$S($D(DGA(1)):DGA(1),1:"NONE ON FILE") D WW1^DGRPV W $S($D(DGA(2)):DGA(2),1:"NO PERMANENT MAILING ADDRESS")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?4 W:'(I#2) ?44 W DGA(I)
 N DGCC
 S DGCC=$$COUNTY(.DGRP,.115)  ; print County if applicable
 W !?4,"County: "_DGCC
 S DGCC=$$COUNTY(.DGRP,.11)  ; print County if applicable
 W ?44,"County: "_DGCC
 W !?5,"Phone: ",$S($P(DGRP(.13),U,1)]"":$P(DGRP(.13),U,1),1:DGRPU)
 W ?42,"Bad Addr: ",$$EXTERNAL^DILFD(2,.121,"",$P(DGRP(.11),U,16))
 W !?4,"Office: ",$S($P(DGRP(.13),U,2)]"":$P(DGRP(.13),U,2),1:DGRPU)
 W !!
 K DGA,DGA1,DGA2
 I $P(DGRP(.121),"^",9)="Y" S DGAD=.121,(DGA1,DGA2)=1 D AL^DGRPU(30)
 I $P(DGRP(.141),"^",9)="Y" I $P($$CAACT(DFN),U) S DGAD=.141,DGA1=1,DGA2=2 D AL^DGRPU(30)
 S Z=3 D WW^DGRPV W " Temporary Mailing Address: " S Z=" ",Z1=9
 D WW1^DGRPV S Z=4,DGRPW=0 D WW^DGRPV W " Confidential Mailing Address: "
 W !?4
 S Z1=40,Z=$S($D(DGA(1)):DGA(1),1:"NO TEMPORARY MAILING ADDRESS") D WW1^DGRPV W $S($D(DGA(2)):DGA(2),1:"NONE ON FILE")
 ; loop through DGA array beginning with DGA(2) and print data at ?5 (odds) and ?44 (evens)
 S I=2 F I1=0:0 S I=$O(DGA(I)) Q:I=""  W:(I#2)!($X>40) !?4 W:'(I#2) ?44 W DGA(I)
 W !
 I $D(DGA(1)) D
 .S DGCC=$$COUNTY(.DGRP,.121)  ; print County if applicable
 .W ?4,"County: "_DGCC
 I $D(DGA(2)) I $P($$CAACT(DFN),U) D
 .S DGCC=$$COUNTY(.DGRP,.141)  ; print County if applicable
 .W ?44,"County: "_DGCC
 W !?5,"Phone: ",$S($P(DGRP(.121),U,9)'="Y":"NOT APPLICABLE",$P(DGRP(.121),U,10)]"":$P(DGRP(.121),U,10),1:DGRPU)
 W ?45,"Phone: ",$S($P(DGRP(.141),U,9)'="Y":"NOT APPLICABLE",'$P($$CAACT(DFN),U):"NOT APPLICABLE",$P(DGRP(.13),U,15)]"":$P(DGRP(.13),U,15),1:DGRPU)
 S X="NOT APPLICABLE"
 I $P(DGRP(.121),U,9)="Y" D
 .S Y=$P(DGRP(.121),U,7) X:Y]"" ^DD("DD")
 .S X=$S(Y]"":Y,1:DGRPU)_"-",Y=$P(DGRP(.121),U,8) X:Y]"" ^DD("DD")
 .S X=X_$S(Y]"":Y,1:DGRPU)
 W !?3,"From/To: ",X
 S DGX="NOT APPLICABLE"
 I $P(DGRP(.141),U,9)="Y" I $P($$CAACT(DFN),U) D
 .S (DGZ,DGX)="" F DGI=7,8 S DGZ=$P(DGRP(.141),"^",DGI),Y=DGZ D
 ..I DGI=7 X:Y]"" ^DD("DD") S DGBEG=Y,DGX=Y
 ..I DGI=8 X:Y]"" ^DD("DD") S DGEND=Y,DGX=DGX_"-"_$S(Y]"":Y,1:"UNANSWERED")
 W ?43,"From/To: "_DGX
 ; DG*5.3*1143 - If RTA group 4 array defined, load the categories from that array if Address is Active
 I $D(DGADDGRP4) D  G CCATPRT
 .; if Confidential Address not active, don't display categories
 .W !?38,"Categories: " I $G(DGADDGRP4(.14105))'="Y" Q
 .S DGCAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 .S DGX="",DGCAN="" F  S DGCAN=$O(DGADDGRP4("CCATS",2.141,DGCAN)) Q:DGCAN=""  D
 ..S DGTYP=DGADDGRP4("CCATS",2.141,DGCAN,.01,"I"),DGACT=DGADDGRP4("CCATS",2.141,DGCAN,1,"I")
 ..S DGACT=$S(DGACT="Y":"Active",DGACT="N":"Inactive",1:"Unanswered")
 ..S DGTYPNAM="" F DGI=1:1 S DGTYPNAM=$P(DGCAT,";",DGI) Q:DGTYPNAM=""  D
 ...I DGTYPNAM[DGTYP S DGTYPNAM=$P(DGTYPNAM,":",2),DGX=DGTYPNAM_"("_DGACT_")"_","_DGX
 ;
 W !?38,"Categories: " I $D(^DPT(DFN,.14)) D
 .; if Confidential Address not active, don't display categories
 .I $P(DGRP(.141),U,9)'="Y" Q
 .I '$P($$CAACT(DFN),U) Q
 .S DGCAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 .S DGX="",DGCAN="" F  S DGCAN=$O(^DPT(DFN,.14,DGCAN)) Q:DGCAN=""  D
 ..Q:'$D(^DPT(DFN,.14,DGCAN,0))
 ..S DGTYP=$P(^DPT(DFN,.14,DGCAN,0),"^",1),DGACT=$P(^DPT(DFN,.14,DGCAN,0),"^",2)
 ..S DGACT=$S(DGACT="Y":"Active",DGACT="N":"Inactive",1:"Unanswered")
 ..S DGTYPNAM="" F DGI=1:1 S DGTYPNAM=$P(DGCAT,";",DGI) Q:DGTYPNAM=""  D
 ...I DGTYPNAM[DGTYP S DGTYPNAM=$P(DGTYPNAM,":",2),DGX=DGTYPNAM_"("_DGACT_")"_","_DGX
 ;
CCATPRT ; DG*5.3*1143 - Add tag for printout out the categories
 S DGXX="",CNT=0 F DGI=1:1 S DGXX=$P(DGX,",",DGI) Q:DGXX=""  D
 .W:CNT>0 !
 .W ?38,DGXX
 .S CNT=CNT+1
 ; DG*5.3*1143 - Add group 5 for cell and email
 S Z=5,DGRPW=0 W ! D WW^DGRPV W " Cell Phone/Email Address: "
 ;
 ;* Output Cell phone
 W !,"       Cell Phone: "
 I $P(DGRP(.13),U,4)'="" W ?19,$P(DGRP(.13),U,4)
 I $P(DGRP(.13),U,4)="" W ?19,"UNANSWERED"
 ;
 ;* Output Email Address
 W !,"    Email Address: "
 I $P(DGRP(.13),U,3)'="" W ?19,$P(DGRP(.13),U,3)
 I $P(DGRP(.13),U,3)="" W ?19,"UNANSWERED"
 ;
 ;
 ; line feed before continuing
 W !
 G ^DGRPP
CAACT(DFN,ACTDT) ;Determines if the Confidential Address is active
 ;Input:  DFN - Patient (#2) file internal entry number (Required)
 ;        ACTDT - Date used to determine if address is active 
 ;                (Optional) Defaults to DT if not defined. 
 ;
 ;Output:
 ;   1st piece 0 inactive based on start/stop dates
 ;             1 active based on start/stop dates
 ;   2nd piece 0 - no active correspondence types
 ;             1 - at least one active correspondence type
 ;
 N DGCA,DGCABEG,DGCAEND,DGSTAT,DGIEN,DGTYP,DGFLG
 S DGSTAT="0^0"
 I '$D(DFN) Q DGSTAT
 I '$D(ACTDT) S ACTDT=DT
 ; DG*5.3*1143 - Get begin and end dates from RTA group array if defined
 I $G(DGADDGRP4(.1417))'="" D
 . S DGCABEG=$G(DGADDGRP4(.1417))
 . S DGCAEND=$G(DGADDGRP4(.1418))
 . I 'DGCABEG!(DGCABEG>ACTDT)!(DGCAEND&(DGCAEND<ACTDT)) Q
 . S DGSTAT="1^0"
 ; DG*5.3*1143 - If no RTA array, get dates from the patient record
 I $G(DGADDGRP4(.1417))="" S DGCA=$G(^DPT(DFN,.141)) D
 . I DGCA="" Q
 . S DGCABEG=$P(DGCA,U,7)
 . S DGCAEND=$P(DGCA,U,8)
 . I 'DGCABEG!(DGCABEG>ACTDT)!(DGCAEND&(DGCAEND<ACTDT)) Q
 . S DGSTAT="1^0"
 ;Build array of correspondence types
 S (DGIEN,DGFLG)=0
 F  S DGIEN=$O(^DPT(DFN,.14,DGIEN)) Q:'DGIEN  D  Q:DGFLG
 .S DGTYP=$G(^DPT(DFN,.14,+DGIEN,0))
 .I $P(DGTYP,U,2)="Y" S DGFLG=1
 S $P(DGSTAT,U,2)=$S(DGFLG=1:1,1:0)
 Q DGSTAT
 ;JAM - Patch DG*5.3*941 - return county
COUNTY(DGRP,FNODE) ;retrieve County info if a US address
 N CNODE,FCPE,IEN,DGCC,PIECE
 S DGCC=""
 ; default data location of address County info
 S PIECE=7,FCPE=10,CNODE=FNODE
 ; data location of Temporary address County info
 I FNODE=.121 S FCPE=3,PIECE=11,CNODE=.122
 ; data location of Confidential address County info
 I FNODE=.141 S PIECE=11,FCPE=16
 S IEN=$P(DGRP(CNODE),U,FCPE)
 I '$$FORIEN^DGADDUTL(IEN) D
 .S DGCC=$S($D(^DIC(5,+$P(DGRP(FNODE),U,5),1,+$P(DGRP(FNODE),U,PIECE),0)):$E($P(^(0),U,1),1,20)_$S($P(^(0),U,3)]"":" ("_$P(^(0),U,3)_")",1:""),1:DGRPU)
 E  S DGCC="NOT APPLICABLE"
 Q DGCC
 ;
LOADLOCAL ; DG*5.3*1143
 ; If local array(s) holding address data exist, load the data from the array(s) into DGRP
 ; DGADDGRP1 is the local array holding data entered into group 1 - Residential Address (see DGREGRED)
 I $D(DGADDGRP1(.1151)) D
 .; Line 1
 .S $P(DGRP(.115),"^",1)=$G(DGADDGRP1(.1151))
 .; Line 2
 .S $P(DGRP(.115),"^",2)=$G(DGADDGRP1(.1152))
 .; Line 3
 .S $P(DGRP(.115),"^",3)=$G(DGADDGRP1(.1153))
 .; City
 .S $P(DGRP(.115),"^",4)=$G(DGADDGRP1(.1154))
 .; State
 .S $P(DGRP(.115),"^",5)=$G(DGADDGRP1(.1155))
 .; Zip  (Residential address only has ZIP+4 field
 .S $P(DGRP(.115),"^",6)=$G(DGADDGRP1(.1156))
 .; County
 .S $P(DGRP(.115),"^",7)=$G(DGADDGRP1(.1157))
 .; Province
 .S $P(DGRP(.115),"^",8)=$G(DGADDGRP1(.11571))
 .; Postal Code
 .S $P(DGRP(.115),"^",9)=$G(DGADDGRP1(.11572))
 .; Country
 .S $P(DGRP(.115),"^",10)=$G(DGADDGRP1(.11573))
 .; Zip+4
 .S $P(DGRP(.115),"^",12)=$G(DGADDGRP1(.1156))
 .; CASS Indicator
 .S $P(DGRP(.115),"^",19)=$G(DGADDGRP1(.1159))
 .; Home phone
 .S $P(DGRP(.13),"^",1)=$G(DGADDGRP1(.131))
 .; Work phone
 .S $P(DGRP(.13),"^",2)=$G(DGADDGRP1(.132))
 ;
 ; DGADDGRP2 is the local array holding data entered into group 2 - Mailing Address (see DGREGAED)
 I $D(DGADDGRP2(.111)) D
 .; Line 1
 .S $P(DGRP(.11),"^",1)=$G(DGADDGRP2(.111))
 .; Line 2
 .S $P(DGRP(.11),"^",2)=$G(DGADDGRP2(.112))
 .; Line 3
 .S $P(DGRP(.11),"^",3)=$G(DGADDGRP2(.113))
 .; City
 .S $P(DGRP(.11),"^",4)=$G(DGADDGRP2(.114))
 .; State
 .S $P(DGRP(.11),"^",5)=$G(DGADDGRP2(.115))
 .; Zip
 .S $P(DGRP(.11),"^",6)=$G(DGADDGRP2(.116))
 .; County
 .S $P(DGRP(.11),"^",7)=$G(DGADDGRP2(.117))
 .; Province
 .S $P(DGRP(.11),"^",8)=$G(DGADDGRP2(.1171))
 .; Postal Code
 .S $P(DGRP(.11),"^",9)=$G(DGADDGRP2(.1172))
 .; Country
 .S $P(DGRP(.11),"^",10)=$G(DGADDGRP2(.1173))
 .; Zip+4
 .S $P(DGRP(.11),"^",12)=$G(DGADDGRP2(.1112))
 .; Bad Address Indicator
 .S $P(DGRP(.11),"^",16)=$G(DGADDGRP2(.121))
 .; CASS Indicator
 .S $P(DGRP(.11),"^",18)=$G(DGADDGRP2(.1118))
 ;
 ; DGADDGRP3 is the local array holding data entered into group 3 - Temp Address (see DGREGTED)
 I $D(DGADDGRP3(.1211)) D
 .; Line 1
 .S $P(DGRP(.121),"^",1)=$G(DGADDGRP3(.1211))
 .; Line 2
 .S $P(DGRP(.121),"^",2)=$G(DGADDGRP3(.1212))
 .; Line 3
 .S $P(DGRP(.121),"^",3)=$G(DGADDGRP3(.1213))
 .; City
 .S $P(DGRP(.121),"^",4)=$G(DGADDGRP3(.1214))
 .; State
 .S $P(DGRP(.121),"^",5)=$G(DGADDGRP3(.1215))
 .; Zip 
 .S $P(DGRP(.121),"^",6)=$G(DGADDGRP3(.1216))
 .; Start Date
 .S $P(DGRP(.121),"^",7)=$G(DGADDGRP3(.1217))
 .; End Date
 .S $P(DGRP(.121),"^",8)=$G(DGADDGRP3(.1218))
 .; Address Active?
 .S $P(DGRP(.121),"^",9)=$G(DGADDGRP3(.12105))
 .; Temp Phone
 .S $P(DGRP(.121),"^",10)=$G(DGADDGRP3(.1219))
 .; County
 .S $P(DGRP(.121),"^",11)=$G(DGADDGRP3(.12111))
 .; Zip+4
 .S $P(DGRP(.121),"^",12)=$G(DGADDGRP3(.12112))
 .; CASS Indicator
 .S $P(DGRP(.121),"^",15)=$G(DGADDGRP3(.12115))
 .; Province
 .S $P(DGRP(.122),"^",1)=$G(DGADDGRP3(.1221))
 .; Postal Code
 .S $P(DGRP(.122),"^",2)=$G(DGADDGRP3(.1222))
 .; Country
 .S $P(DGRP(.122),"^",3)=$G(DGADDGRP3(.1223))
 ;
 ; DGADDGRP4 is the local array holding data entered into group 4 - Confidential Address (see DGREGTED)
 I $D(DGADDGRP4(.1411)) D
 .; Line 1
 .S $P(DGRP(.141),"^",1)=$G(DGADDGRP4(.1411))
 .; Line 2
 .S $P(DGRP(.141),"^",2)=$G(DGADDGRP4(.1412))
 .; Line 3
 .S $P(DGRP(.141),"^",3)=$G(DGADDGRP4(.1413))
 .; City
 .S $P(DGRP(.141),"^",4)=$G(DGADDGRP4(.1414))
 .; State
 .S $P(DGRP(.141),"^",5)=$G(DGADDGRP4(.1415))
 .; Zip 
 .S $P(DGRP(.141),"^",6)=$G(DGADDGRP4(.1416))
 .; Start Date
 .S $P(DGRP(.141),"^",7)=$G(DGADDGRP4(.1417))
 .; End Date
 .S $P(DGRP(.141),"^",8)=$G(DGADDGRP4(.1418))
 .; Address Active?
 .S $P(DGRP(.141),"^",9)=$G(DGADDGRP4(.14105))
 .; County
 .S $P(DGRP(.141),"^",11)=$G(DGADDGRP4(.14111))
 .; Province
 .S $P(DGRP(.141),"^",14)=$G(DGADDGRP4(.14114))
 .; Postal Code
 .S $P(DGRP(.141),"^",15)=$G(DGADDGRP4(.14115))
 .; Country
 .S $P(DGRP(.141),"^",16)=$G(DGADDGRP4(.14116))
 .; Conf Phone
 .S $P(DGRP(.13),"^",15)=$G(DGADDGRP4(.1315))
 .; CASS Indicator
 .S $P(DGRP(.141),"^",17)=$G(DGADDGRP4(.14117))
 ;
 ; EMAIL
 I $D(DGADDGRP5(.133)) S $P(DGRP(.13),U,3)=$G(DGADDGRP5(.133))
 ; Cell number 
 I $D(DGADDGRP5(.134)) S $P(DGRP(.13),U,4)=$G(DGADDGRP5(.134))
 Q
 ;
 ; DG*5.3*1143 - Called when Real-time address updates are active and data is ready to send to ES via webservice before saving in Vista.
 ;   This call point is used to send edits to ES and save to DB if webservice call is successful
 ;   Called from:
 ;   - ^DGRPP when the User selects (S)ave from screen 1.1 option to save all edits on the screen
 ;   - SAVEADDR^DGRPU1 after editing of data is completed
 ;   - SAVEADDR^DGADDUTL - DGADDRESS UPDATE option when user edits both Mailing and Temp address
RTASEND(DFN) ; Send data to ES via the RTA update service and save if valid response
 ; Returns:  1 - Real-time address update was successful
 ;           0 - unsuccessful save - Error messages are displayed on the screen indicating the reason for the failure
 ;                                    The caller can determine how to handle the failure
 ; One or more of these arrays are created by edit routines to send to ES when RTA is active.
 ; DGADDGRP1 - Residential Address group, filled by DGREGRED
 ; DGADDGRP2 - Mailing Address group, filled by DGREGAED
 ; DGADDGRP3 - Temp Address group, filled by DGREGTED for Temp address
 ; DGADDGRP4 - Confidential Address group, filled by DGREGTED for Conf address
 ; DGADDGRP5 - Email and cell phone, filled by DR115^DGRPE1 when editing group 5 on screen 1.1
 ; 
 N DGRTARET,DGERRS
 S DGRTARET=$$EN^DGRTAUPD(DFN,.DGERRS,.DGADDGRP1,.DGADDGRP2,.DGADDGRP3,.DGADDGRP4,.DGADDGRP5)
 ; Unsuccessful response - display error messages to user
 I 'DGRTARET D
 . N X,Z,DGI,DGLINE,DIWR,DGL,DIWL,DIWF
 . S DIWR=75,DIWL=0,DIWF=""
 . ; Print out the message attached to the return
 . S X=$P(DGRTARET,"^",2)
 . K ^UTILITY($J,"W")
 . D ^DIWP
 . M DGLINE=^UTILITY($J,"W",0)
 . W !!,"** Webservice call failed:" F DGL=1:1:DGLINE W DGLINE(DGL,0),!
 . ; Print out the DGERRS text
 . S DGI="" F  S DGI=$O(DGERRS(DGI)) Q:'DGI  D
 . . W !,"("_DGI_") "
 . . S X=DGERRS(DGI)
 . . K ^UTILITY($J,"W")
 . . D ^DIWP
 . . M DGLINE=^UTILITY($J,"W",0)
 . . F DGL=1:1:DGLINE W DGLINE(DGL,0),!
 . D EOP
 ;
 I DGRTARET D
 .; For each group that was edited, call the logic to save and clean up their edit data variables
 .I $D(DGADDGRP1) D SAVEFROMLOCAL^DGREGRED
 .I $D(DGADDGRP2) D SAVEFROMLOCAL^DGREGAED
 .I $D(DGADDGRP3) D SAVEFROMLOCAL^DGREGTED("TEMP")
 .I $D(DGADDGRP4) D SAVEFROMLOCAL^DGREGTED("CONF")
 .I $D(DGADDGRP5) D SAVEFROMLOCAL
 .W !,"Changes saved."
 .D EOP
 Q DGRTARET
 ;
SAVEFROMLOCAL ; DG*5.3*1143 - Save screen 1.1 group 5 data into the database
 N DGN,DGVALUE,FDA
 S DGN=0
 F  S DGN=$O(DGADDGRP5(DGN)) Q:'DGN  D
 . S DGVALUE=DGADDGRP5(DGN)
 . S FDA(2,DFN_",",DGN)=DGVALUE
 . ; for phone number, update the extension field
 . I DGN=.134 S FDA(2,DFN_",",.13212)=$P(DGADDGRP5(DGN),"X",2)
 D FILE^DIE("","FDA","MSG")
 ; Clean out the RTA variables
 D CLEANGRP5
 Q
 ;
DISCARD ; DG*5.3*1143 - Discard action on screen 1.1 (called from ^DGRPP)
 ; Call each edit routine to clean out their RTA variables
 D CLEAN^DGREGTED("TEMP")
 D CLEAN^DGREGTED("CONF")
 D CLEAN^DGREGRED
 D CLEAN^DGREGAED
CLEANGRP5 ; Clean Group 5 RTA variables
 K DGADDEDIT(5),DGADDGRP5
 Q
CLEAN ; Clean out RTA variables used by all routines from screen 1.1 - called by ^DGRPP when user is leaving screen 1.1
 K DGRTAON,DGRTAHOLD
 Q
 ;
EOP ; DG*5.3*1143
 N DIR,X,Y
 S DIR(0)="E"
 S DIR("A")="Press ENTER to continue"
 D ^DIR
 ; DG*5.3*1040 - Set variable DGTMOT=1, if timeout
 S:$D(DTOUT) DGTMOT=1,DGRPOUT=1
 Q
