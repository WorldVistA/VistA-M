MDRPCNT ; HOIFO/NCA - Document Handler Object (TMDNOTE) ;5/23/05  15:50
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Reference IA #2944 [Subscription] Calls to TIUSRVR1.
 ;               2240 [Supported] ENCRYP^XUSRB1 call
 ;               2241 [Supported] DECRYP^XUSRB1 call
 ;               2693 [Subscription] TIULQ call
 ;
RPC(RESULTS,OPTION,MDSID,MDTIU,MDDTE,MDAUTH,MDESIG,MDNTL,MDTXT) ; [Procedure] Main RPC call
 ; RPC: [MD TMDNOTE]
 ;
 ; MDSID=702 IEN
 ; MDTIU=Note Internal Entry Number
 ; MDDTE=Date/Time of Note
 ; MDAUTH=Author of Note
 ; MDESIG=Encoded E-Sig
 ; MDNTL=Note Title
 ; MDTXT=Array containing the text for the note
 ;
 D CLEAN^DILF
 S RESULTS=$NA(^TMP("MDKUTL",$J)) K @RESULTS
 I $T(@OPTION)="" D  Q
 .S @RESULTS@(0)="-1^Error in RPC: MD TMDNOTE at "_OPTION_U_$T(+0)
 D @OPTION S:'$D(@RESULTS) @RESULTS@(0)="-1^No return"
 D CLEAN^DILF
 Q
 ;
NEWDOC ; Add additional new note
 ;
 I '$D(^MDD(702,+MDSID,0)) S @RESULTS@(0)="-1^No such study" Q
 I $D(MDTXT)<1 S @RESULTS@(0)="-1^No note text" Q
 K ^TMP("MDTXT",$J)
 N X,Y S X="",Y=0
 F  S X=$O(MDTXT(X)) Q:X=""  S Y=Y+1,^TMP("MDTXT",$J,Y)=MDTXT(X)
 I Y<1 S @RESULTS@(0)="-1^No note text" Q
 S MDESIG=$$DECRYP^XUSRB1(MDESIG),MDESIG=$$ENCRYP^XUSRB1(MDESIG)
 I $G(MDDTE)="" D NOW^%DTC S MDDTE=% K %
 S @RESULTS@(0)=$$SUBMIT^MDRPCNT1(+MDSID,MDDTE,MDAUTH,MDESIG,MDNTL,$NA(^TMP("MDTXT",$J)))
 ;
 K ^TMP("MDTXT",$J)
 Q
 ;
NOTELIST ; Get list of documents
 ; Return:
 ;    Note Ien
 ;    Note Title
 ;    Date/Time Creation
 ;    Author
 ;
 N MDCST,MDDL,MDK,MDX1 S MDDL="" K ^TMP("MDDLST",$J)
 S MDK=0 F  S MDK=$O(^MDD(702.001,"ASTUDY",MDSID,MDK)) Q:MDK<1  S MDX1=+MDK D
 .N MDDOC,MDTIUER
 .S (MDDOC,MDTIUER)="" K ^TMP("MDTIUST",$J)
 .D EXTRACT^TIULQ(+MDX1,"^TMP(""MDTIUST"",$J)",MDTIUER,".01;.05;1201;1202;1205") Q:+MDTIUER
 .I $G(^TMP("MDTIUST",$J,MDX1,.05,"E"))'="COMPLETED" Q
 .S @RESULTS@(MDK)=+MDX1_"^"_$G(^TMP("MDTIUST",$J,MDX1,.01,"E"))_"^"_$G(^TMP("MDTIUST",$J,MDX1,1201,"E"))_"^"_$G(^TMP("MDTIUST",$J,MDX1,1202,"E"))_"^"_$G(^TMP("MDTIUST",$J,MDX1,1205,"E"))
 .K ^TMP("MDTIUST",$J)
 .Q
 Q
 ;
VIEWTIU ; [Procedure] View the associated TIU document
 I '$G(MDTIU) S @RESULTS@(0)="-1^NO TIU NOTE FOR THIS STUDY" Q
 D TGET^TIUSRVR1(.RESULTS,+MDTIU)
 Q
