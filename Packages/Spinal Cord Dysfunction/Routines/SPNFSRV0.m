SPNFSRV0 ;HISC/DAD-SCD REGISTRY VETERAN SURVEY SERVER ;2/6/96  09:34
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 D XIT
 S SPNFXMZ=XMZ
 S SPNFTYPE=$$XMREC,SPNERROR=0
 I ";***154^REG;***154.1^FIM;"'[(";"_SPNFTYPE_";") D  G EXIT
 . S X="Invalid message format, rest of message ignored."
 . D ERROR(X)
 . Q
 K SPNFDATA
 S (SPNFREGC,SPNFFIMC,SPNFEXIT,SPNFDATA("E"))=0
 F  S SPNFDATA=$$XMREC Q:SPNFDATA=""!SPNFEXIT  D
 . ;
 . I SPNFDATA="***^END" D  Q
 .. S X=$O(SPNFDATA("")) I (X="")!(X="E") Q
 .. S SPNFDFN(0)=$P($G(SPNFDATA(0)),U)
 .. S SPNFDFN=$$FINDDFN(SPNFDFN(0))
 .. I SPNFDFN'>0 D  Q
 ... S SPNFNAME=$P(SPNFDFN(0),";"),SPNFSEX=$P(SPNFDFN(0),";",2)
 ... S SPNFDOB=$P(SPNFDFN(0),";",3),SPNFSSN=$P(SPNFDFN(0),";",4)
 ... S SPNFDOB=$E(SPNFDOB,4,5)_"-"_$E(SPNFDOB,6,7)_"-"_$E(SPNFDOB,2,3)
 ... S SPNFSEX=$S(SPNFSEX="M":"MALE",SPNFSEX="F":"FEMALE",1:"UNKNOWN")
 ... S X="Patient not found: "_SPNFNAME_"  ("_SPNFSEX_")  "
 ... S X=X_SPNFDOB_"  "_SPNFSSN_"."
 ... K SPNFDATA S SPNFDATA("E")=0
 ... D ERROR(X)
 ... Q
 .. I $P(SPNFTYPE,U,2)="REG" D REG^SPNFSRV1
 .. I $P(SPNFTYPE,U,2)="FIM" D FIM^SPNFSRV2
 .. K SPNFDATA S SPNFDATA("E")=0
 .. Q
 . ;
 . S SPNFTAG=$P(SPNFDATA,U),SPNFDATA=$P(SPNFDATA,U,2,99)
 . S SPNFSUB=$TR(SPNFTAG,"*")
 . I (SPNFTAG'?1"*"1E1"*")!("^0^2^5^E^"'[(U_SPNFSUB_U)) D  Q
 .. S X="Invalid message format, rest of message ignored."
 .. D ERROR(X)
 .. S SPNFEXIT=1
 .. Q
 . I SPNFSUB?1N S SPNFDATA(SPNFSUB)=SPNFDATA
 . E  D
 .. S SPNFDATA("E")=SPNFDATA("E")+1
 .. S SPNFDATA("E",SPNFDATA("E"))=SPNFDATA
 .. Q
 . Q
 ;
EXIT ; *** Send error/info msg, Clean-up, Quit
 I SPNERROR'>0 S XMSER="SPNFSURVEY",XMZ=SPNFXMZ D REMSBMSG^XMA1C
 D MESSAGE
XIT K D0,D1,DA,DD,DESC,DFN,DIC,DIE,DINUM,DLAYGO,DO,DOB,DPT,DR,DTOUT,IEN
 K NAM,SEX,SPND0,SPND1,SPNDATE,SPNDR,SPNERROR,SPNETIOL,SPNFDATA
 K SPNFDATE,SPNFDFN,SPNFDOB,SPNFEXIT,SPNFFIMC,SPNFFLDS,SPNFFTYP
 K SPNFNAME,SPNFREGC,SPNFSEX,SPNFSSN,SPNFSTAT,SPNFSUB,SPNFTAG,SPNFTYPE
 K SPNFXMZ,SPNONSET,SPNOTHER,SPNPIECE,SPNX,SSN,TYPE,X,Y
 K ^TMP($J,"SPNERROR")
 Q
 ;
MESSAGE ; *** Send user error/info message
 I SPNERROR D
 . S X="The SCD Registry Veteran Survey Server has encountered the"
 . S ^TMP($J,"SPNERROR",.1)=X
 . S X="following problems with MailMan server message # "_SPNFXMZ_":"
 . S ^TMP($J,"SPNERROR",.2)=X
 . S ^TMP($J,"SPNERROR",.3)=""
 . Q
 E  D
 . S X="The SCD Registry Veteran Survey Server has added or modified"
 . S ^TMP($J,"SPNERROR",.1)=X
 . S X="the following number of records:"
 . S ^TMP($J,"SPNERROR",.2)=X
 . I $P(SPNFTYPE,U,2)="REG" D
 .. S ^TMP($J,"SPNERROR",.3)="   SCD Registry records: "_SPNFREGC
 .. Q
 . I $P(SPNFTYPE,U,2)="FIM" D
 .. S ^TMP($J,"SPNERROR",.3)="            FIM records: "_SPNFFIMC
 .. Q
 . Q
 S XMSUB="SCD Registry Veteran Survey Server"
 S XMTEXT="^TMP($J,""SPNERROR"","
 S XMY("G.SPNL SCD COORDINATOR")=""
 S XMY("G.SPNZ SCD COORDINATOR")=""
 D ^XMD
 Q
 ;
FINDDFN(X) ; *** Find a patient DFN
 ;  X = Name ; Sex ; DOB ; SSN ; LAST NAME
 N D0,DFN,DOB,DPT,LNM,NAM,SEX,SSN
 S NAM=$P(X,";",1),SEX=$P(X,";",2)
 S DOB=$P(X,";",3),SSN=$P(X,";",4)
 S LNM=$P(X,";",5)
 S (D0,DFN)=0
 F  S D0=$O(^DPT("SSN",SSN,D0)) Q:D0'>0!DFN  D
 . S DPT=$G(^DPT(D0,0))
 . S NAM(0)=$P(DPT,U,1),SEX(0)=$P(DPT,U,2)
 . S DOB(0)=$P(DPT,U,3),SSN(0)=$P(DPT,U,9)
 . I NAM=NAM(0),SEX=SEX(0),DOB=DOB(0),SSN=SSN(0) S DFN=D0
 . I DFN'>0,SSN=SSN(0),LNM=$P(NAM(0),",") S DFN=D0
 . Q
 Q DFN
 ;
ERROR(X) ; *** Save error messages
 ;  X = Text of the error msg
 S SPNERROR=SPNERROR+1
 S ^TMP($J,"SPNERROR",SPNERROR)=X
 Q
 ;
XMREC() ; *** Return next line of message
 X XMREC
 Q $S(XMER=0:XMRG,1:"")
