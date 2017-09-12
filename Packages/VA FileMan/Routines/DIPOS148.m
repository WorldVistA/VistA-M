DIPOS148 ;SFISC/SO- RE-SET PRE-OPEN & POS-CLOSE FOR BROWSER ;12:50 PM  10 Apr 2006
 ;;22.0;VA FileMan;**148**;Mar 30, 1999
 N FDA,IEN,X,Y,DIERR,ZERR,Q
 S Q=""""
 D MES^XPDUTL("Begin post install DI*22*148...")
 S IEN=+$$FIND1^DIC(3.5,"","X","BROWSER","B","","ZERR")
 I 'IEN D  D CLEAN^DILF Q
 . D MES^XPDUTL("Not able to find device named: BROWSER, no editing preformed.")
 . D MES^XPDUTL("Finished  post install DI*22*148.")
 . Q
 S IEN=IEN_","
 ; Set PRE-OPEN EXECUTE(#19.7)
 S FDA(3.5,IEN,19.7)="N X S X=$$TEST^DDBRT S:X IO=$P(IO,"_Q_".TXT"_Q_")_$J_"_Q_".TXT"_Q_" I 'X S %ZISQUIT=1,X="_Q_"Browser not selectable from current terminal."_Q_" W $C(7),!,X"
 S X=^%ZOSF("OS")
 I X'["OpenM" D  Q
 . D MES^XPDUTL("Not ""OpenM"", setting only the PRE-OPEN EXECUTE(#19.7).")
 . D EDIT
 . Q
 D MES^XPDUTL("Setting only the PRE-OPEN EXECUTE(#19.7).")
 S X=$ZV
 ; Set POST-CLOSE EXECUTE(#19.8)
 S Y="D POST^DDBRZIS I ^%ZOSF("_Q_"OS"_Q_")["_Q_"OpenM"_Q_",$G(IO("_Q_"CLOSE"_Q_"))'="_Q_Q_" N X S X=$ZV,X=$ZF(-1,"_Q_"del "_Q_"_IO("_Q_"CLOSE"_Q_")_$S(X["_Q_"VMS"_Q_":"_Q_";*"_Q_",1:"_Q_Q_"))"
 S:X["VMS" FDA(3.5,IEN,19.8)=Y
 S:X["Windows" FDA(3.5,IEN,19.8)=Y
 I $D(FDA(3.5,IEN,19.8)) D MES^XPDUTL("Setting POST-CLOSE EXECUTE(#19.8).")
EDIT D FILE^DIE("","FDA")
 D CLEAN^DILF
 D MES^XPDUTL("Finished  post install DI*22*148.")
 Q
