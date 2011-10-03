RGADTP2 ;BIR/DLR-ADT PROCESSOR TO RETRIGGER A08 or A04 MESSAGES WITH AL/AL (COMMIT/APPLICATION) ACKNOWLEDGEMENTS - CONTINUED ;10/30/02  10:04
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**27,20,45,44,47,48,49,52,54**;30 Apr 99;Build 4
DBIA ;
 ;Reference to $$ADD^VAFCEHU1 supported by IA #2753
 ;Reference to EDIT^VAFCPTED supported by IA #2784
 Q
PROCIN(ARRAY,RGLOCAL,RGER,DFN,HL) ;
 N RGRSDFN,OTHSITE,NODE,ICN,CMORIEN,CMOR,CMORDISP,SENSTVTY,RMTDOD,LOCDOD,VAFCA,VAFCA08,HERE,BOGUS,ARAY,REP
 S REP=$E(HL("ECH"),2)
 S HERE=$P($$SITE^VASITE,"^",3)
 ;if sending site is your site quit
 Q:$G(ARRAY("MPISSITE"))=$G(HERE)
 S ARRAY(.097)=$P($$NOW^XLFDT,".")
 I $G(ARRAY("ICN"))'="" D
 .S RGRSDFN=$$GETDFN^MPIF001(+ARRAY("ICN")) I +RGRSDFN<1 S RGER=RGRSDFN_" ICN#"_$G(ARRAY("ICN")) Q  ;quit and return error msg
 .S OTHSITE=ARRAY("SENDING SITE") ;**40 REMOVED THE PLUS TO KEEP SUFFIX ON STATION# & CHANGED THE SITE TO BE SENDING SITE INSTEAD OF AUTHORITATIVE SOURCE
 I $G(RGRSDFN)="" S RGRSDFN=$G(DFN)
 I $G(RGRSDFN)="" S RGER="-1^DFN not defined"
 Q:$G(RGER)
 I $G(OTHSITE)="" S OTHSITE=""
 S NODE=$$MPINODE^MPIFAPI(RGRSDFN)
 S ICN=$P(NODE,"^")
 S CMORIEN=$P(NODE,"^",3)
 S CMOR=$$NS^XUAF4(CMORIEN)
 S CMORDISP=$P(CMOR,"^",1)
 S CMOR=$P(CMOR,"^",2)
 ;
 ;If patient is Sensitive at other site but not here send bulletin
 I $G(ARRAY("SENSITIVITY"))'="" S SENSTVTY=$G(ARRAY("SENSITIVITY")) D
 .N NAME S NAME=ARRAY("NAME")
 .I '$$SENSTIVE^RGRSENS(RGRSDFN),SENSTVTY D
 ..S ARAY("SSN")=ARRAY("SSN"),ARAY("SENDING SITE")=ARRAY("SENDING SITE")
 ..S ARAY("SENSITIVITY USER")=ARRAY("SENSITIVITY USER"),ARAY("SENSITIVITY DATE")=ARRAY("SENSITIVITY DATE")
 ..D SENSTIVE^RGRSBUL1(RGRSDFN,"ARAY",NAME)
 ;
 ;MPIC_772 - **52; Commented out Remote Date of Death Indicated section.
 ;If patient has DATE OF DEATH (DOD) at remote site send bulletin
 ;Ignore time if present with date.
 ;S RMTDOD=$G(ARRAY("MPIDOD")),RMTDOD=$P(RMTDOD,".")
 ;S DFN=RGRSDFN D DEM^VADPT
 ;S LOCDOD=$P($P(VADM(6),"^"),".")
 ;If there is a remote DOD but no local DOD  OR if remote DOD is different from local DOD, send bulletin
 ;I RMTDOD D
 ;.N NAME S NAME=ARRAY("NAME"),ARAY("SSN")=ARRAY("SSN"),ARAY("SENDING SITE")=ARRAY("SENDING SITE")
 ;.D RMTDOD^RGRSBUL1(RGRSDFN,"ARAY",NAME,RMTDOD,LOCDOD)
 ;K VADM
 ;
NOTLOC I 'RGLOCAL D
 .;if sending site is not the CMOR AND NOT THE MPI - log update into PDR if differences exist **45 ADDED MPI
 .I (OTHSITE)'=(CMOR)&(OTHSITE'="200M") D  Q
 ..S VAFCA=$P($$NOW^XLFDT,".")_"^"_$$NOW^XLFDT_"^"_$G(ARRAY("SENDING SITE"))_"^"_RGRSDFN
 ..S ARRAY(.01)=$$FREE^RGRSPARS(ARRAY("NAME")),ARRAY(.03)=$$FREE^RGRSPARS($G(ARRAY("MPIDOB")))
 ..S ARRAY(.09)=$$FREE^RGRSPARS($G(ARRAY("SSN"))),ARRAY(.02)=$$SEX^RGRSPARS($G(ARRAY("SEX")))
 ..S ARRAY(.2403)=$$FREE^RGRSPARS($G(ARRAY("MMN"))),ARRAY(991.01)=$P($G(ARRAY("ICN")),"V")
 ..N ARAY M ARAY(2)=ARRAY
 ..S VAFCA08=1  ;S BOGUS=$$ADD^VAFCEHU1(VAFCA,"ARAY") comment out by RG*1*49
 .;if sending site is the CMOR OR MPI - synchronize data **45 ADDED MPI AND SSNV TO UPDATED FIELDS
 .I (OTHSITE)=(CMOR)!(OTHSITE="200M") D
 ..;**44 is there an outstanding edit in the ADT/HL7 PIVOT file for this patient for an identity element
 ..S RGER=$$CHKPVT^RGADTP3(.ARRAY) Q:+RGER<0
 ..N DR,ARAY2 S RGER=""
 ..D DIFF^RGADTP3(.ARRAY,RGRSDFN,.DR,.ARRAY) ;**47
 ..I DR'="" D
 ...S VAFCA08=1,ARAY(2,.01)=ARRAY("NAME"),ARAY(2,.03)=$G(ARRAY("MPIDOB"))
 ...I ARRAY("SSN")'="" S ARAY(2,.09)=$G(ARRAY("SSN")) ;**45 only set SSN to update if it isn't null
 ...S ARAY(2,.02)=$G(ARRAY("SEX")),ARAY(2,.2403)=$G(ARRAY("MMN")),ARAY(2,994)=$G(ARRAY("MBI"))
 ...;**48 ONLY SET SSN VERIFICATION STATUS AND PSEUDO SSN REASON IF SSN UPDATE WAS SUCCESSFUL
 ...I $D(ARRAY("ALIAS")) M ARAY(2,1)=ARRAY("ALIAS") ;**48 ADD ALIAS TO MIX
 ...D EDIT^VAFCPTED(RGRSDFN,"ARAY(2)",DR)
 ...;check to see if edits were successful, if not set RGER="why it failed"
 ...N NAME,SSN,PDOB,SEX,MMN,OLDNAME,OLDHLNAM,OLDMMN,OLDHLMMN,HLNAME,HLMMN,SSNV,MBI
 ...S NAME=$$GET1^DIQ(2,+RGRSDFN_",",.01,"I"),PDOB=$$GET1^DIQ(2,+RGRSDFN_",",.03,"I")
 ...S SSN=$$GET1^DIQ(2,+RGRSDFN_",",.09,"I"),SEX=$$GET1^DIQ(2,+RGRSDFN_",",.02,"I")
 ...S MMN=$$GET1^DIQ(2,+RGRSDFN_",",.2403,"I"),MBI=$$GET1^DIQ(2,+RGRSDFN_",",994,"I")
 ...D STDNAME^XLFNAME(.NAME,"F",.OLDNAME) S HLNAME=ARRAY("NAME") D STDNAME^XLFNAME(.HLNAME,"F",.OLDHLNAM)
 ...I NAME'=$G(HLNAME) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"Name field failure"
 ...I PDOB'=$G(ARRAY("MPIDOB")) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"DOB field failure"
 ...;**48
 ...I SSN["P" D
 ....;if pseudo SSN reason field has been added to the DD then attempt to set it
 ....N PS,ERROR,LABEL D FIELD^DID(2,.0906,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 .....S ARAY2(2,.0906)=$G(ARRAY(.0906)),DR=".0906;" D EDIT^VAFCPTED(RGRSDFN,"ARAY2(2)",DR)
 .....S PS=$$GET1^DIQ(2,+RGRSDFN_",",.0906,"I")
 .....I PS=""&(ARAY2(2,.0906)="@") Q
 .....I PS'=ARAY2(2,.0906) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"Pseudo SSN Reason field failure"
 .....I PS=ARAY2(2,.0906) D
 ......K ARAY2 N ERROR,LABEL D FIELD^DID(2,.0907,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 ......S ARAY2(2,.0907)=$G(ARRAY(.0907)),DR=".0907;" D EDIT^VAFCPTED(RGRSDFN,"ARAY2(2)",DR)
 ......S SSNV=$$GET1^DIQ(2,+RGRSDFN_",",.0907,"I")
 ......S:$G(ARRAY(.0907))="@" ARRAY(.0907)="" I SSNV'=$G(ARRAY(.0907)) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"SSN VERIFICATION field failure"
 ...I $G(ARRAY("SSN"))'="",$G(ARRAY("SSN"))'="@",SSN'=$G(ARRAY("SSN")) D
 ....;**54 mpic_1556 added array("ssn")'="@"
 ....I $G(ARRAY("SSN"))="P",SSN["P" Q  ;**47 NEEDED TO CREATE PSEUDO AND DID
 ....S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"SSN field failure" ;**45 only check if SSN is sent isn't null
 ...I SSN=$G(ARRAY("SSN")) D
 ....;if SSN VERIFICATION STATUS field has been added to the DD then attempt to set it
 ....K ARAY2 N ERROR,LABEL D FIELD^DID(2,.0907,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 .....S ARAY2(2,.0907)=$G(ARRAY(.0907)) S DR=".0907;" D EDIT^VAFCPTED(RGRSDFN,"ARAY2(2)",DR)
 .....S SSNV=$$GET1^DIQ(2,+RGRSDFN_",",.0907,"I")
 .....S:$G(ARRAY(.0907))="@" ARRAY(.0907)="" I SSNV'=$G(ARRAY(.0907)) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"SSN VERIFICATION field failure"
 .....I SSNV'="" D
 ......N PS,ERROR,LABEL D FIELD^DID(2,.0906,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 ......S ARAY2(2,.0906)=$G(ARRAY(.0906)) S DR=".0906;" D EDIT^VAFCPTED(RGRSDFN,"ARAY2(2)",DR)
 ......S PS=$$GET1^DIQ(2,+RGRSDFN_",",.0906,"I")
 ......I PS=""&(ARAY2(2,.0906)="@") Q
 ......S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"Pseudo SSN Reason field failure"
 ...;**54 Need to see if should delete pseudo ssn reason if SSN isn't a pseudo and there is a pseudo reason, delete it.
 ...I SSN'["P" N PS,ERROR,LABEL D FIELD^DID(2,.0906,"","LABEL","LABEL","ERROR") I '$D(ERROR("DIERR"))&$D(LABEL("LABEL")) D
 ....S PS=$$GET1^DIQ(2,+RGRSDFN_",",.0906,"I")
 ....I PS'=""  S ARAY2(2,.0906)="@",DR=".0906;" D EDIT^VAFCPTED(RGRSDFN,"ARAY2(2)",DR)
 ...I SEX'=$G(ARRAY("SEX")) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"SEX field failure"
 ...D STDNAME^XLFNAME(.MMN,"F",.OLDMMN) S HLMMN=ARRAY("MMN") D STDNAME^XLFNAME(.HLMMN,"F",.OLDHLMMN)
 ...I MMN'=$G(HLMMN) S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"MOTHER'S MAIDEN NAME field failure"
 ...;**REMOVED MBI FROM PATCH 45 PUT BACK IN **47
 ...I MBI'=$G(ARRAY("MBI")) D
 ....Q:MBI=""&($G(ARRAY("MBI"))="@")  ;**47 "" AND @ ARE THE SAME
 ....S RGER=$S($G(RGER)'="":$G(RGER)_REP,1:"-1^")_"MULTIPLE BIRTH INDICATOR field failure"
 ...;send the updated fields to the MPI to synch site with MPI
 ...I HL("ETN")'="A31" S ZTSAVE("DFN")="",ZTRTN="MPISYN^RGADTPC",ZTDESC="Sending Synchronized Patient Data to MPI...",ZTIO="RG QUEUE",ZTDTH=$H D ^%ZTLOAD
 ...;**45 ^ don't trigger A31 sync message if A31 was being processed-- ack to a31 will sync id elements on MPI
 Q
