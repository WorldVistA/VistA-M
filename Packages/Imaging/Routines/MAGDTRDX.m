MAGDTRDX ;WOIFO/PMK - Formatted dump of DICOM MWL & TeleReader dictionaries ; 27 Feb 2013 9:35 AM
 ;;3.0;IMAGING;**46,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
ENTRY ;
 D WORKLIST,TELEREAD
 Q
 ;
WORKLIST ; display the clinical specialty DICOM MWL and HL7 configuration files
 N ACQSITE,CLINNAME,CLINPTR,CPTIEN,D0,D1,D2,D3,DIVISION,HL7SUBLIST
 N I,IPROCIDX,ISPECIDX,LOCKTIME,MSG,POP,PRIMARY,PROC,ROUTE,SERVICE,STATUS
 N TIUNOTE,TRIGGER,USERPREF,X,X1,X2,X3
 D ^%ZIS Q:POP  ; Select device quit if none
 O IO:"WN" U IO
 S (MSG(1),MSG(3))=""
 S MSG(2)="CLINICAL SPECIALTY DICOM & HL7 file (#2006.5831) -- "_$$HTE^XLFDT($H,"2M")
 W !! D HEADING(.MSG)
 S D0=0 F  S D0=$O(^MAG(2006.5831,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.5831,D0,0))
 . S SERVICE=$P(X,"^",1),PROC=$P(X,"^",2),ISPECIDX=$P(X,"^",3)
 . S IPROCIDX=$P(X,"^",4),DIVISION=$P(X,"^",5)
 . S CPTIEN=$P(X,"^",6),HL7SUBLIST=$P(X,"^",7)
 . W !!?13,$S(PROC:"-- Procedure",1:" -- Consult")," --"
 . W !,$$W("Request Service:"),$$GET1^DIQ(123.5,SERVICE,.01)
 . I PROC W !,$$W("Procedure:"),$$GET1^DIQ(123.3,PROC,.01)
 . W !,$$W("Worklist:"),$$GET1^DIQ(2005.84,ISPECIDX,3)
 . I IPROCIDX W "/",$$GET1^DIQ(2005.85,IPROCIDX,3)
 . W " (",$$GET1^DIQ(2005.84,ISPECIDX,.01)
 . I IPROCIDX W "/",$$GET1^DIQ(2005.85,IPROCIDX,.01)
 . W ")"
 . W !,$$W("Acquired at:"),$$GET1^DIQ(4,DIVISION,99)," -- ",$$GET1^DIQ(4,DIVISION,.01)
 . S ROUTE=$$GET1^DIQ(123.5,SERVICE,132)
 . I ROUTE'="" D
 . . W !,$$W("Remote IFC:"),ROUTE
 . . Q
 . I CPTIEN D
 . . W !,$$W("CPT Code:"),$$GET1^DIQ(81,CPTIEN,.01)
 . . W " -- ",$$GET1^DIQ(81,CPTIEN,2)
 . . Q
 . I HL7SUBLIST W !,$$W("HL7 Subscriber List:"),$$GET1^DIQ(779.4,HL7SUBLIST,.01)
 . S CLINPTR=0
 . S D1=0 F  S D1=$O(^MAG(2006.5831,D0,1,D1)) Q:'D1  D
 . . I 'CLINPTR W !,$$W("Clinic(s):")
 . . S CLINPTR=$G(^MAG(2006.5831,D0,1,D1,0))
 . . S CLINNAME=$$GET1^DIQ(44,CLINPTR,.01)
 . . I $X+$L(CLINNAME)>70 W !,$$W("")
 . . W CLINNAME,"    "
 . . Q
 . ;
 . ; output Associated Stop Code(s) if any
 . K X D GETS^DIQ(123.5,SERVICE,"**","E","X")
 . I $D(X(123.5688)) D
 . . S I="" F  S I=$O(X(123.5688,I)) Q:I=""  D
 . . . W !,$$W("Associated Stop Code:"),X(123.5688,I,.01,"E")
 . . . Q
 . . Q
 . E  D
 . . W !,"Warning: No Associated Stop Codes are defined for this Request Service."
 . . W !,"         Use CONSULT ASSOCIATED STOP CODE menu option to define them."
 . Q
 C IO U $P
 Q
 ;
TELEREAD ; display the TeleReader configuration files
 N ACQSITE,CLINNAME,CLINPTR,CPTCODE,D0,D1,D2,D3,DIVISION,HL7SUBLIST
 N IPROCIDX,ISPECIDX,LOCKTIME,MSG,POP,PRIMARY,PROC,ROUTE,SERVICE,STATUS
 N TIUNOTE,TRIGGER,USERPREF,X,X1,X2,X3
 S (MSG(1),MSG(3))=""
 S MSG(2)="TELEREADER ACQUISITION SERVICE file (#2006.5841) -- "_$$HTE^XLFDT($H,"2M")
 I '$D(IO) D ^%ZIS Q:POP  ; Select device quit if none
 O IO:"WA" U IO
 W !! D HEADING(.MSG)
 S D0=0 F  S D0=$O(^MAG(2006.5841,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.5841,D0,0))
 . S SERVICE=$P(X,"^",1),PROC=$P(X,"^",2),ISPECIDX=$P(X,"^",3)
 . S IPROCIDX=$P(X,"^",4),DIVISION=$P(X,"^",5)
 . S TRIGGER=$P(X,"^",6),TIUNOTE=$P(X,"^",7)
 . W !!,$$W("Request Service:"),$$GET1^DIQ(123.5,SERVICE,.01)
 . I $D(^MAG(2006.5831,SERVICE,0)) W ?63,"*** DICOM MWL ***"
 . I PROC W !,$$W("Procedure:"),$$GET1^DIQ(123.3,PROC,.01)
 . S ROUTE=$$GET1^DIQ(123.5,SERVICE,132)
 . I ROUTE'="" D
 . . W !,$$W("Remote IFC:"),ROUTE
 . . Q
 . W !,$$W(" Unread List:"),$$GET1^DIQ(2005.84,ISPECIDX,.01)
 . W " -- ",$$GET1^DIQ(2005.85,IPROCIDX,.01)
 . W !,$$W("Trigger:")
 . I TRIGGER="I" W "Create/update with every acquired image"
 . E  I TRIGGER="O" W "Create when request is ordered"
 . E  I TRIGGER="F" W "Create when consult is forwarded"
 . E  W "Unknown trigger value: """,TRIGGER,""""
 . I TIUNOTE W !,$$W("Note for IFC:"),$$GET1^DIQ(8925.1,TIUNOTE,.01)
 . Q
 ;
 S MSG(2)="TELEREADER ACQUISITION SITE file (#2006.5842)"
 W !! D HEADING(.MSG)
 S D0=0 F  S D0=$O(^MAG(2006.5842,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.5842,D0,0))
 . S ACQSITE=$P(X,"^",1),PRIMARY=$P(X,"^",2)
 . S STATUS=$P(X,"^",3),LOCKTIME=$P(X,"^",4)
 . W !!,$$W("Acquisition:"),$$GET1^DIQ(4,ACQSITE,.01)
 . W ?50,$S(STATUS:"Active",1:"Inactive")
 . W ?60,"Lock Time: ",LOCKTIME," min."
 . W !,$$W("Primary Site:"),$$GET1^DIQ(4,PRIMARY,.01)
 . Q
 ;
 S MSG(2)="TELEREADER READER file (#2006.5843)"
 W !! D HEADING(.MSG)
 S D0=0 F  S D0=$O(^MAG(2006.5843,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.5843,D0,0))
 . W:D0>1 !!,$TR($J("",80)," ","-")
 . W !!,$$W("TeleReader:"),$$GET1^DIQ(200,X,.01)
 . S D1=0 F  S D1=$O(^MAG(2006.5843,D0,1,D1)) Q:'D1  D
 . . S X1=$G(^MAG(2006.5843,D0,1,D1,0))
 . . S ACQSITE=$P(X1,"^",1),STATUS=$P(X1,"^",2)
 . . W !!,$$W("Acquisition:"),$$GET1^DIQ(4,ACQSITE,.01)
 . . W ?50,$S(STATUS:"Active",1:"Inactive")
 . . S D2=0 F  S D2=$O(^MAG(2006.5843,D0,1,D1,1,D2)) Q:'D2  D
 . . . S X2=$G(^MAG(2006.5843,D0,1,D1,1,D2,0))
 . . . S ISPECIDX=$P(X2,"^",1),STATUS=$P(X2,"^",2)
 . . . W !,$$W(" Unread List:"),$$GET1^DIQ(2005.84,ISPECIDX,.01)
 . . . W ?50,$S(STATUS:"Active",1:"Inactive")
 . . . S D3=0 F  S D3=$O(^MAG(2006.5843,D0,1,D1,1,D2,1,D3)) Q:'D3  D
 . . . . S X3=$G(^MAG(2006.5843,D0,1,D1,1,D2,1,D3,0))
 . . . . S IPROCIDX=$P(X3,"^",1),STATUS=$P(X3,"^",2),USERPREF=$P(X3,"^",3)
 . . . . W !,$$W(""),$$GET1^DIQ(2005.85,IPROCIDX,.01)
 . . . . W ?50,$S(STATUS:"Active",1:"Inactive")
 . . . . W ?65,"User: ",$S(USERPREF:"Active",1:"Inactive")
 . . . . Q
 . . . Q
 . . Q
 . Q
 W !,$TR($J("",80)," ","*"),!
 W !!,"End of Report",!
 C IO U $P
 Q
 ;
W(PROMPT) ; output prompt
 Q $J(PROMPT,21)_" "
 ;
HEADING(MSG) ;
 N I
 W !,$TR($J("",80)," ","*")
 I $D(MSG)=1 W !,"*** ",MSG,?76," ***"
 E  F I=1:1 Q:'$D(MSG(I))  W !,"*** ",MSG(I),?76," ***"
 W !,$TR($J("",80)," ","*")
 Q
 ;
