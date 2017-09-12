LR458 ;DALOI/JMC - LA*5.2*458 KIDS ROUTINE ;9/2/15  11:40
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**458**;Sep 27, 1994;Build 10
 ;
PRE ;
 ; KIDS Pre install for LA*5.2*458
 D BMES("*** Pre install started ***")
 ;
 ;
 D BMES("*** Pre install completed ***")
 ;
 Q
 ;
 ;
POST ;
 ; KIDS Post install for LA*5.2*458
 D BMES("*** Post install started ***")
 ;
 I $G(^TMP("LA88A",$J,1)) D RESTORE^LA88A
 ;
 ;
 D BMES("*** Post install completed ***")
 D BMES("Sending install completion alert to mail group G.LMI")
 S STR="Installation of patch "_$G(XPDNM,"Unknown patch")_" completed on "_$$HTE^XLFDT($H)
 D ALERT(STR)
 ;
 Q
 ;
 ;
ALERT(MSG,RECIPS) ;
 N DA,DIK,XQA,XQAMSG
 S XQAMSG=$G(MSG)
 I '$$GOTLOCAL^XMXAPIG("LMI") S XQA("G.LMI")=""
 E  S XQA(DUZ)=""
 I $D(RECIPS) M XQA=RECIPS
 D SETUP^XQALERT
 Q
 ;
 ;
BMES(STR) ;
 ; Write string
 D BMES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," "))
 Q
 ;
 ;
PROGRESS(LAST) ;
 ; Prints a "." when NOW > LAST + INT
 ; Input
 ;   LAST : <byref> The last $H when "." was shown
 N INT
 S INT=1 ;interval in seconds
 I $P($H,",",2)>(+$P(LAST,",",2)+INT) S LAST=$H W "."
 Q
 ;
 ;
PTG ;
 ; Pre-Transport Global routine
 Q
 ;
 ;
MES(STR,CJ,LM) ;
 ; Display a string using MES^XPDUTL
 ;  Inputs
 ;  STR: String to display
 ;   CJ: Center text?  1=yes 0=1 <dflt=1>
 ;   LM: Left Margin (padding)
 N X
 S STR=$G(STR)
 S CJ=$G(CJ,1)
 S LM=$G(LM)
 I CJ S STR=$$TRIM^XLFSTR($$CJ^XLFSTR(STR,$G(IOM,80)),"R"," ")
 I 'CJ I LM S X="" S $P(X," ",LM)=" " S STR=X_STR
 D MES^XPDUTL(STR)
 Q
