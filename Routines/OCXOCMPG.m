OCXOCMPG ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Sort Code Segments cont...) ;5/08/01  10:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32,105**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN(OCXL,OCXCNT) ;
 ;
 N OCXCODE,OCXVAR
 D IN^OCXOCMP4(OCXL," ;")
 S OCXCODE=""
 ;
 I $L(OCXMCOD) D
 .;
 .D IN^OCXOCMP4(OCXL," ;")
 .D IN^OCXOCMP4(OCXL," ; Run Execute Code")
 .D IN^OCXOCMP4(OCXL," ;")
 .;
 .N NEWVAL,FLDNAME,FCNT,X
 .S NEWVAL=OCXMCOD
 .F FCNT=1:1 Q:'(NEWVAL["|")  S NEWVAL=$P(NEWVAL,"|",1)_"X"_FCNT_$P(NEWVAL,"|",3,$L(NEWVAL,"|"))
 .S X=NEWVAL D ^DIM
 .I '$D(X) D  Q
 ..N MESG
 ..S MESG(1)="**** WARNING *****************************************************"
 ..S MESG(2)=""
 ..S MESG(3)="The Execute code: "_OCXMCOD
 ..S MESG(4)="     Rule Format: "_$G(OCXR("R",OCXD1,"MCODE"))
 ..S MESG(5)=""
 ..S MESG(6)="    In Rule: ["_(+$G(OCXD0))_"]  "_$P($G(^OCXS(860.2,+$G(OCXD0),0)),U,1)
 ..S MESG(7)="   Relation: ["_(+$G(OCXD1))_"]  "_$G(^OCXS(860.2,+$G(OCXD0),"R",+$G(OCXD1),"E"))
 ..S MESG(8)=""
 ..S MESG(9)=" Did not pass the mumps syntax check. The code has been disabled."
 ..S MESG(10)="   This rule may not work correctly until the code is fixed."
 ..S MESG(11)="******************************************************************"
 ..S MESG(12)=""
 ..F FCNT=1:1 Q:'$D(MESG(FCNT))  D IN^OCXOCMP4(OCXL," ;"_MESG(FCNT))
 ..F FCNT=1:1 Q:'$D(MESG(FCNT))  D MESG(MESG(FCNT))
 .;
 .D IN^OCXOCMP4(OCXL," "_OCXMCOD)
 ;
 D IN^OCXOCMP4(OCXL," Q:$G(OCXOERR)")
 I ($P(OCXNOD0,U,3)),$L(OCXNMSG) D
 .D IN^OCXOCMP4(OCXL," ;")
 .D IN^OCXOCMP4(OCXL," ; Send Notification")
 .D IN^OCXOCMP4(OCXL," ;")
 .D IN^OCXOCMP4(OCXL," S (OCXDUZ,OCXDATA)="""",OCXNUM=0")
 .D IN^OCXOCMP4(OCXL," I ($G(OCXOSRC)=""GENERIC HL7 MESSAGE ARRAY"") D")
 .D IN^OCXOCMP4(OCXL," .S OCXDATA="_$$HL7("ORC",2)_"_""|""_"_$$HL7("ORC",3))
 .D IN^OCXOCMP4(OCXL," .S OCXDATA=$TR(OCXDATA,""^"",""@""),OCXNUM=+OCXDATA")
 .D IN^OCXOCMP4(OCXL," I ($G(OCXOSRC)=""CPRS ORDER PROTOCOL"") D")
 .D IN^OCXOCMP4(OCXL," .I $P($G(OCXORD),U,3) S OCXDUZ(+$P(OCXORD,U,3))=""""")
 .D IN^OCXOCMP4(OCXL," .S OCXNUM=+$P(OCXORD,U,2)")
 .D IN^OCXOCMP4(OCXL," S:($G(OCXOSRC)=""CPRS ORDER PRESCAN"") OCXNUM=+$P(OCXPSD,""|"",5)")
 .D IN^OCXOCMP4(OCXL," S OCXRULE("""_OCXL_""")=""""")
 .D IN^OCXOCMP4(OCXL," I $$NEWRULE(DFN,OCXNUM,"_OCXD0_","_OCXD1_","_(+$P(OCXNOD0,U,3))_",OCXNMSG) D  I 1")
 .D IN^OCXOCMP4(OCXL," .D:($G(OCXTRACE)<5) EN^ORB3("_(+$P(OCXNOD0,U,3))_",DFN,OCXNUM,.OCXDUZ,OCXNMSG,.OCXDATA)")
 .I $G(OCXTRACE) D
 ..D IN^OCXOCMP4(OCXL," .I $G(OCXTRACE) D  I 1")
 ..D IN^OCXOCMP4(OCXL," ..N OCXANS")
 ..D IN^OCXOCMP4(OCXL," ..W !")
 ..D IN^OCXOCMP4(OCXL," ..I ($G(OCXTRACE)>5) W !,""    ***  TEST MODE - Notification not sent to ORB3 ***""")
 ..D IN^OCXOCMP4(OCXL," ..E  W !,""    ***  Notification sent to EN^ORB3 ***""")
 ..D IN^OCXOCMP4(OCXL," ..W !,"" Notification: "_+$P(OCXNOD0,U,3)_" ("_$P(OCXNOD0,U,3)_")""")
 ..D IN^OCXOCMP4(OCXL," ..W !,""          DFN: "",DFN")
 ..D IN^OCXOCMP4(OCXL," ..W !,"" Order Number: "",OCXNUM")
 ..D IN^OCXOCMP4(OCXL," ..W !,""      Message: "",OCXNMSG")
 ..D IN^OCXOCMP4(OCXL," ..W !,""         DATA: "",OCXDATA")
 ..D IN^OCXOCMP4(OCXL," ..W !,""     OCXTRACE: "",OCXTRACE")
 ..D IN^OCXOCMP4(OCXL," ..W:$D(OCXORD) !,""  OCXORD DATA: "",OCXORD")
 ..D IN^OCXOCMP4(OCXL," ..I $L($T(LOGAL^OCXDEBUG)) D LOGAL^OCXDEBUG("_OCXD0_","_OCXD1_","_(+$P(OCXNOD0,U,3))_",DFN,OCXNUM,"""",OCXNMSG,.OCXDATA)")
 ..D IN^OCXOCMP4(OCXL," E  I $G(OCXTRACE) W !,||LNTAG||,?30,""Message: Rule already triggered""")
 ;
 I ($P(OCXNOD0,U,2)),$L(OCXCMSG) D
 .D IN^OCXOCMP4(OCXL," ;")
 .D IN^OCXOCMP4(OCXL," ; Send Order Check Message")
 .D IN^OCXOCMP4(OCXL," ;")
 .D IN^OCXOCMP4(OCXL," S OCXOCMSG($O(OCXOCMSG(999999),-1)+1)=OCXCMSG")
 ;
 Q OCXWARN
 ;
HL7(S,P) ;
 ;
 ;Q "$G(OCXODATA("""_S_""","_P_"))"
 Q "$G(^TMP(""OCXSWAP"",$J,""OCXODATA"","""_S_""","_P_"))"
 ;
 ;
MESG(OCXX) ;
 I '$G(OCXAUTO) W !,OCXX
 I ($G(OCXAUTO)=1) D BMES^XPDUTL(.OCXX)
 Q
 ;
