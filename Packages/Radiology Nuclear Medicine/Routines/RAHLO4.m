RAHLO4 ;HIRMFO/GJC-File rpt (data from bridge program) ;7/21/99  11:45
 ;;5.0;Radiology/Nuclear Medicine;**4,8,81,84**;Mar 16, 1998;Build 13
 ;
 ;Integration Agreements
 ;----------------------
 ;NOW^%DTC(10000); %ZTLOAD(10063); FIND^DIC(2051); ^DIE(10018); ^DIK(10013); $$GET1^DIQ(2056)
 ;GETS^DIQ(2056); ^XMD(10070)
 ;
TASK ; Task ORU message
 S ZTDESC="Rad/Nuc Med Compiling HL7 ORU Message",ZTDTH=$H,ZTIO="",ZTRTN="RPT^RAHLRPC",ZTSAVE("RADFN")="",ZTSAVE("RADTI")="",ZTSAVE("RACNI")="",ZTSAVE("RARPT")=""
 ;Next line of coding will assure that ORU (report) message will be sent after posible ORM message. (10 second)
 S $P(ZTDTH,",",2)=$P(ZTDTH,",",2)+4 S:$P(ZTDTH,",",2)>86400 ZTDTH=$P(ZTDTH,",")+1_","_($P(ZTDTH,",",2)-86400)
 S:$L($G(RANOSEND)) ZTSAVE("RANOSEND")="" D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 Q
VOICE ; voice dictation auto-print (background process)
 Q:$P(^RA(79.1,+$G(RAMLC),0),U,26)'="Y"  ; Voice Dictation Auto-Print
 S ZTIO=$$GET1^DIQ(3.5,+$P(^RA(79.1,+$G(RAMLC),0),U,10),.01) ; dev name
 Q:ZTIO']""  ; quit if the device does not exist
 S ZTDTH=$H,ZTRTN="DQ^RARTR",ZTSAVE("RARPT")=""
 S ZTDESC="Rad/Nuc Med voice dictation auto-print"
 D ^%ZTLOAD K RAMES,ZTDESC,ZTSK,ZTIO,ZTSAVE,ZTRTN,RASV,ZTDTH
 Q
 ;
UPMEM ;copy (prim:dx,stf,res),rpt ien to other members of same print set
 ; first clear those fields
 K DIE,DA,DR S DA=RACNI,DA(1)=RADTI,DA(2)=RADFN
 S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 S DR="13///@;12///@;15///@" D ^DIE
 ; now set those fields based on lead case of printset
 S DR="13////"_RA13_";12////"_RA12_";15////"_RA15 D ^DIE K DA,DR,DIE
 ; now set the report pointer (uneditable, thus must hard set)
 S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)=RARPT
 Q
SETPHYS ;set Primary Resident or Staff, either piece 12 or piece 15 of case
 Q:RADPIECE'=15&(RADPIECE'=12)
 S DR=RADPIECE_"////"_$G(RAVERF)
 S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI
 S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 D ^DIE K DA,DR
 Q
KILSECDG ;kill secondary diagnoses nodes of this case
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 Q:RADFN=""!(RADTI="")!(RACNI="")
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0))
 S DA(3)=RADFN,DA(2)=RADTI,DA(1)=RACNI
 N RA1 S RA1=""
K1 S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RA1)) G:RA1="" KQ
 S DA=RA1
 S DIK="^RADPT("_DA(3)_",""DT"","_DA(2)_",""P"","_DA(1)_",""DX"","
 D ^DIK
 G K1
KQ K DA Q
 ;
PCEXTR(RASUB,RASEG,RAPCE,RADEL) ; extract the right piece of data
 ; from the right data node
 ; input: RASUB-data node subscript
 ;        RASEG-HL7 segment (minus the segment header)
 ;        RAPCE-data's piece position
 ;        RADEL-delimiter (field separator)
 S RAHL70="",RAHL7X=0,RAHL7OFF=$L(RASEG,RADEL)
 S RAHL7LST=$P(RASEG,RADEL,RAHL7OFF)
 I RAPCE<RAHL7OFF S RAHL70=$P(RASEG,RADEL,RAPCE) D KILL Q RAHL70
 I RAHL7OFF=RAPCE D  ; check if data wraps to the next node (if any)
 . S RAHL70=$P(RASEG,RADEL,RAPCE),II1=$O(^TMP("RARPT-HL7",$J,RASUB,0))
 . S:'II1 RAHL7X=1 Q:'II1
 . S RAHL70=RAHL70_$P(^TMP("RARPT-HL7",$J,RASUB,II1),RADEL),RAHL7X=1
 . Q
 I RAHL7X D KILL Q RAHL70
 ; check if this node has descendent data nodes
 I '$O(^TMP("RARPT-HL7",$J,RASUB,0)) D KILL Q "" ; descendents not found
 S I=0,RAHL7CNT=RAHL7OFF
 F  S I=$O(^TMP("RARPT-HL7",$J,RASUB,I)) Q:I'>0  D  Q:RAHL7X
 . S RAHL7SUB=$G(^TMP("RARPT-HL7",$J,RASUB,I))
 . S RAHL7PRE=$O(^TMP("RARPT-HL7",$J,RASUB,I),-1)
 . S:RAHL7PRE RAHL7LST=$$LSTPCE(^TMP("RARPT-HL7",$J,RASUB,RAHL7PRE),RADEL)
 . F II1=1:1:$L(RAHL7SUB,RADEL) D  Q:RAHL7X
 .. ; HL7 may have broken the string on data!
 .. I II1=1 S RAHL7ARY(RAHL7CNT)=RAHL7LST_$P(RAHL7SUB,RADEL)
 .. E  D  ; for the case II1'=1
 ... S RAHL7CNT=RAHL7CNT+1
 ... S RAHL7ARY(RAHL7CNT)=$P(RAHL7SUB,RADEL,II1)
 ... Q
 .. I RAHL7CNT=RAPCE,(II1'=$L(RAHL7SUB,RADEL)) S RAHL7X=1,RAHL70=RAHL7ARY(RAHL7CNT)
 .. I RAHL7CNT=RAPCE,(II1=$L(RAHL7SUB,RADEL)) D
 ... ; grab the 1st piece of the next node (if any)
 ... S RAHL7X=1,RAHL70=RAHL7ARY(RAHL7CNT)
 ... S N1=+$O(^TMP("RARPT-HL7",$J,RASUB,I)) Q:'N1
 ... S RAHL70=RAHL70_$P(^TMP("RARPT-HL7",$J,RASUB,N1),RADEL)
 ... Q
 .. K:'RAHL7X RAHL7ARY
 .. Q
 . Q
 D KILL
 Q RAHL70
KILL ; kill the RAHLD* variables
 K I,II1,N1,RAHL7ARY,RAHL7CNT,RAHL7LST,RAHL7OFF,RAHL7PRE,RAHL7SUB,RAHL7X
 Q
LSTPCE(X,DEL) ; given a string and a delimiter, return the last piece
 Q $P(X,DEL,$L(X,DEL))
CKDUPA ; if duplicate addendum, send msg to members of unverify rpt mailgroup
 S RADUPA=0 ; 0 means not a duplicate
 N I1,I2,X1,X2,X3,X4,X21,R0,R1,R2,MATCH,XMSUB
 S I1="I",I2="RAIMP" I $O(^RARPT(RARPT,I1,0))'="" D ISITDUP ;Q:'RADUPA
 ;
 I 'RADUPA S I1="R",I2="RATXT" I $O(^RARPT(RARPT,I1,0))'="" D ISITDUP Q:'RADUPA
 ;S I1="R",I2="RATXT" I $O(^RARPT(RARPT,I1,0))'="" D ISITDUP Q:'RADUPA
 ;
 S XMSUB="Duplicate addendum being sent to Vista"
 ;
 ; check to see if mail message already sent for
 ; this case no. TODAY only. if so quit - no need to
 ; re-send to save time backwards $ORDER, duplicate
 ; most likely to be most recently.
 S (XMB,XMATCH)=""
 D NOW^%DTC S RATDY=X K X
 F  S XMB=$O(^XMB(3.9,"B",$E(XMSUB,1,30),XMB),-1) Q:XMB=""  D  Q:XMATCH'=""
 .I $P($$GET1^DIQ(3.9,XMB,1.4,"I"),".")'=RATDY S XMATCH=0 Q  ;(DBIA2860)
 .Q:$G(^XMB(3.9,XMB,2,6,0))'[RALONGCN
 .S XMATCH=1
 K XMB,RATDY
 Q:XMATCH=1
 ;
 ; send mail to members of unverify bulletin  (DBIA2861)
 ; find ien of unverify bulletin
 D FIND^DIC(3.6,"","","","RAD/NUC MED REPORT UNVERIFIED",1,"","","","R0")
 Q:'$D(R0("DILIST",2,1))#2
 ; find name of mail group linked to that bulletin
 D GETS^DIQ(3.6,R0("DILIST",2,1),"4*","EI","R1")
 ; check to see if MailGroup is PUBLIC, otherwise quit
 S X=$G(R1(3.62,"1,"_R0("DILIST",2,1)_",",.01,"I")) I X="" K X Q
 I $$GET1^DIQ(3.8,X_",",4,"I")'="PU" K X Q
 S X=$G(R1(3.62,"1,"_R0("DILIST",2,1)_",",.01,"E")) I X="" K X Q
 N XMDUZ,XMTEXT,XMY,MSGTXT,XRAVERF,XRATRANS,XRADFN
 S X="G."_X,XMY(X)="" K X ;recipient mail group
 ;
 S XMDUZ=.5
 S MSGTXT(1)=$G(^TMP("RARPT-REC",$J,RASUB,"VENDOR"))_" is sending duplicate addenda to Radiology/Nuclear Medicine."
 S MSGTXT(2)=" "
 S MSGTXT(3)="The following radiology report was sent with a duplicate addendum:"
 S:RADFN'="" XRADFN=$$GET1^DIQ(2,RADFN,.01)
 S:$G(XRADFN)="" XRADFN="Unknown"
 S MSGTXT(4)="   1) Patient              : "_XRADFN
 S MSGTXT(5)="   2) SSN                  : "_$$SSN^RAUTL()
 S MSGTXT(6)="   3) Case Number          : "_RALONGCN
 S:RAVERF'="" XRAVERF=$$GET1^DIQ(200,RAVERF,.01)
 S:$G(XRAVERF)="" XRAVERF="Unknown"
 S MSGTXT(7)="   4) Verifier             : "_XRAVERF
 S:RATRANSC'="" XRATRANS=$$GET1^DIQ(200,RATRANSC,.01)
 S:$G(XRATRANS)="" XRATRANS="Unknown"
 S MSGTXT(8)="   5) Transcriptionist     : "_XRATRANS
 S MSGTXT(9)=" "
 S MSGTXT(10)="Please notify IRM."
 S XMTEXT="MSGTXT("
 D ^XMD
 Q
ISITDUP ; X1=last ien ^RARPT, X2=LAST IEN ^TMP, x21=first ien ^TMP
 Q:'$O(^TMP("RARPT-REC",$J,RASUB,I2,0))
 N X1,X2,X21,X3,X4,XX
 S RADUPA=0 ; Reset to zero otherwise Imp Text match will override
 S X1=$O(^RARPT(RARPT,I1,""),-1)
 S XX=$G(^RARPT(RARPT,I1,X1,0)) S XX=$S(XX=""!(XX=" "):0,1:1)
 S X2=$O(^TMP("RARPT-REC",$J,RASUB,I2,""),-1),X21=$O(^(0))
 S X3=X1-X2+XX Q:X3<1  ; begin comparison from ^RARPT(RARPT,I1,X3
 ; chk 1st line of previous addendum
 Q:^RARPT(RARPT,I1,X3,0)'["Addendum: "  S X4=^(0)
 S X4=$E(X4,$L("Addendum: ")+1,$L(X4)) ; exclude "Addendum: " from X4
 Q:X4'=^TMP("RARPT-REC",$J,RASUB,I2,X21)
 ; chk remaining lines
 S X21=X21+1 F X1=X21:1:X2 S X3=X3+1 Q:^RARPT(RARPT,I1,X3,0)'=^TMP("RARPT-REC",$J,RASUB,I2,X1)
 Q:X1<X2
 S RADUPA=1
 Q
