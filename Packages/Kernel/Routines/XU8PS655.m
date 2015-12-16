XU8PS655 ;ISD/HGW - Post-Install for 655 ;03/30/15  11:55
 ;;8.0;KERNEL;**655**;Jul 10, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Post Installation Routine for patch XU*8.0*655
 ;  EXTERNAL REFERENCES
 ;    BMES^XPDUTL 10141
 ;    $$FIND1^DIC
 ;    UPDATE^DIE 2053
 ;
MAIN ; Control subroutine
 N XU8ERRX,XU8DATA
 ;  Install entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="IAM PROVISIONING" ; Name
 S XU8DATA(2)="XUS IAM USER PROVISIONING" ; ContextOption Name
 S XU8DATA(3)="IAM User Provisioning" ; ContextOption Menu Text
 S XU8DATA(4)="put butter square hat" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="H"_"^"_"80"_"^"_"WWW.DOMAIN.EXT"_"^"_"/IAM/Web/Validate.aspx"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ;  Install entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="IAM BINDING" ; Name
 S XU8DATA(2)="XUS IAM USER BINDING" ; ContextOption Name
 S XU8DATA(3)="IAM User Binding App" ; ContextOption Menu Text
 S XU8DATA(4)="de$lAyING55AMO)BAe29" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="H"_"^"_"80"_"^"_"WWW.DOMAIN.EXT"_"^"_"/IAM/Web/Validate.aspx"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 D VACAA ;Load non-VA providers
 Q
 ;
OPTION(XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG
 S XU8IEN=$$FIND1^DIC(19,"","X",XU8DATA(2),"B")
 S XU8ERR="Error message: "_XU8IEN
 I +XU8IEN>0 S XU8ERR="OPTION exists at IEN = "_XU8IEN
 I +XU8IEN=0 S XU8ERR="OPTION "_XU8DATA(2)_" created" D
 . S XU8FDA(19,"?+1,",.01)=XU8DATA(2)
 . S XU8FDA(19,"?+1,",1)=XU8DATA(3)
 . S XU8FDA(19,"?+1,",4)="B" ; B:Broker (Client/Server)
 . D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 . I $D(XU8MSG) S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create OPTION entry "_XU8DATA(2)
 D CLEAN^DILF
 Q XU8ERR
 ;
CREATE(XU8DATA) ; Create new REMOTE APPLICATION entry
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG,XU8I,XU8IENS,DA,DIK
 ; Delete existing entry if it exists, before creating updated entry
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 S XU8ERR="   REMOTE APPLICATION entry created: "_XU8DATA(1)
 S XU8FDA(8994.5,"?+1,",.01)=XU8DATA(1) ; NAME
 S XU8FDA(8994.5,"?+1,",.02)=$$FIND1^DIC(19,"","X",XU8DATA(2),"B") ; CONTEXTOPTION
 S XU8FDA(8994.5,"?+1,",.03)=$$EN^XUSHSH(XU8DATA(4)) ; APPLICATIONCODE
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create REMOTE APPLICATION "_XU8DATA(1)
 ; Find the REMOTE APPLICATION
 S XU8IENS=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I +XU8IENS<1 S XU8ERR=XU8IENS Q XU8ERR
 ; Fill in CALLBACKTYPE multiple
 S XU8I=4 F  S XU8I=$O(XU8DATA(XU8I)) Q:XU8I=""  D
 . N XU8FDA,XU8IEN,XU8MSG,XU8TEST,XU8J,XU8FLAG
 . ; Check for duplicates (loop through CALLBACKTYPE for this entry)
 . S XU8J=0 F  S XU8J=$O(^XWB(8994.5,XU8IENS,1,"B",$E(XU8DATA(XU8I),1,1),XU8J)) Q:(XU8J="")!($D(XU8FLAG))  D
 . . I $G(XU8DATA(XU8I))=$G(^XWB(8994.5,XU8IENS,1,XU8J,0)) S XU8FLAG=1
 . I '$D(XU8FLAG) D
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.01)=$P(XU8DATA(XU8I),"^",1) ; CALLBACKTYPE
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.02)=$P(XU8DATA(XU8I),"^",2) ; CALLBACKPORT
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.03)=$P(XU8DATA(XU8I),"^",3) ; CALLBACKSERVER
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.04)=$P(XU8DATA(XU8I),"^",4) ; URLSTRING
 . . D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 . . I $D(XU8MSG) D
 . . . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to update REMOTE APPLICATION "_XU8DATA(1)
 ;
 D CLEAN^DILF
 Q XU8ERR
 ;
VACAA ;Load non-VA providers to file #200
 ; Identify unique provider using NPI.
 ;^XU8P655("VACAA",j,0)="VISN^UID^NAME (encrypted)^DEGREE^SEX^ADDR1^ADDR2^ADDR3^CITY^STATE^ZIP^NPI^TAX ID^DEA^TW or HN"
 ;ZEXCEPT: XPDIDTOT,XPDNM ;environment variables for KIDS install
 N AUTHCODE,INARRAY,INDATA,INDEXB,INDEXG,INDEXU,J,M,X,XSTATE,UGLYFLAG,VISN
 Q:'$$PROD^XUPROD                                ;Quit if test account
 S DUZ(0)="@"
 S AUTHCODE="This entry point is for VACAA only. No morons."
 S INARRAY=""
 S VISN=$P($$PRNT^XUAF4($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2)),U,3) ;Lookup IEN, then Station, then VISN (returns "VISN ##")
 S VISN=$TR(VISN,"VISN ") ;Return VISN number (no text)
 K ^XU8P655("THEGOOD")
 K ^XU8P655("THEBAD")
 K ^XU8P655("THEUGLY")
 S (INDEXG,INDEXB,INDEXU)=0 ;Initialize the "good, bad, and ugly" indexes
 S J=0,X="-1^Can't add provider"
 S XPDIDTOT=81513 ; put total number of entries in spreadsheet here
 F  D  Q:J=""
 . S J=$O(^XU8P655("VACAA",J)) Q:J=""
 . S INDATA=$G(^XU8P655("VACAA",J,0))
 . I $D(XPDNM)&'(J#10) D UPDATE^XPDID(J) ;Update progress bar
 . ; Only load data appropriate for the site's VISN
 . I VISN=$P(INDATA,U,1) D
 . . ; Decrypt NAME
 . . S $P(INDATA,U,3)=$$AESDECR^XUSHSH($$B64DECD^XUSHSH($P(INDATA,U,3)),"BaDcefghijklmnop")
 . . S INARRAY(1)=$P(INDATA,U,3) ;NAME
 . . S INARRAY(2)=$P(INDATA,U,4) ;DEGREE
 . . S INARRAY(3)=$P(INDATA,U,5) ;SEX
 . . S INARRAY(4)=$P(INDATA,U,6) ;STREET ADDRESS 1
 . . S INARRAY(5)=$P(INDATA,U,7) ;STREET ADDRESS 2
 . . S INARRAY(6)=$P(INDATA,U,8) ;STREET ADDRESS 3
 . . S INARRAY(7)=$P(INDATA,U,9) ;CITY
 . . S INARRAY(8)=$P(INDATA,U,10) ;STATE
 . . S INARRAY(9)=$P(INDATA,U,11) ;ZIP
 . . S INARRAY(10)=$P(INDATA,U,12) ;NPI
 . . S INARRAY(11)=$P(INDATA,U,13) ;TAX ID
 . . S INARRAY(12)=$P(INDATA,U,14) ;DEA #
 . . S INARRAY(13)=$P(INDATA,U,15) ;TW or HN
 . . S X=$$VACAA^XUESSO3(.INARRAY,AUTHCODE)
 . . ;Collect the good (success), the bad (fail), and the ugly (requires manual review) in separate globals
 . . I +X<0 D
 . . . S INDEXB=INDEXB+1
 . . . S ^XU8P655("THEBAD",INDEXB,0)=$J($E($P(X,U,2),1,18),18)_" "_$J($E($P(INDATA,U,3),1,35),35)
 . . I +X>0 D
 . . . S UGLYFLAG=0
 . . . I $P(INDATA,U,3)'=$P($G(^VA(200,X,0)),U,1) D THEUGLY(.INDEXU,.UGLYFLAG,"NPI/NAME mismatch",X,$P(INDATA,U,3)) ;NAME
 . . . I $E($P(INDATA,U,6),1,50)'=$P($G(^VA(200,X,.11)),U,1) D THEUGLY(.INDEXU,.UGLYFLAG,"Bad Address",X,$P(INDATA,U,3)) ;STREET ADDRESS 1
 . . . I $P(INDATA,U,9)'=$P($G(^VA(200,X,.11)),U,4) D THEUGLY(.INDEXU,.UGLYFLAG,"Mismatch city",X,$P(INDATA,U,3)) ;CITY
 . . . S XSTATE=$P($G(^VA(200,X,.11)),U,5) ;STATE pointer
 . . . I $G(XSTATE)'="" D
 . . . . I $P(INDATA,U,10)'=$P($G(^DIC(5,XSTATE,0)),U,2) D THEUGLY(.INDEXU,.UGLYFLAG,"Mismatch state",X,$P(INDATA,U,3)) ; STATE
 . . . I $P(INDATA,U,11)'=$P($G(^VA(200,X,.11)),U,6) D THEUGLY(.INDEXU,.UGLYFLAG,"Mismatch zip",X,$P(INDATA,U,3)) ;ZIP CODE
 . . . I $P(INDATA,U,14)'=$P($G(^VA(200,X,"PS")),U,2) D THEUGLY(.INDEXU,.UGLYFLAG,"Bad DEA#",X,$P(INDATA,U,3)) ;DEA #
 . . . I 'UGLYFLAG D
 . . . . S INDEXG=INDEXG+1
 . . . . S ^XU8P655("THEGOOD",INDEXG,0)=$J($E(X,1,15),15)_" "_$J($E($P(INDATA,U,3),1,35),35)
 ; Send mail alerts to G.PATCHES for the good, the bad, and the ugly
 S M=$$BULL("THEGOOD")
 D BMES^XPDUTL("MailMan message #"_M_" lists non-VA Providers successfully loaded")
 S M=$$BULL("THEBAD")
 D BMES^XPDUTL("MailMan message #"_M_" lists non-VA Providers that failed to load")
 S M=$$BULL("THEUGLY")
 D BMES^XPDUTL("MailMan message #"_M_" lists non-VA Providers loaded, requiring manual review")
 K ^XU8P655("VACAA")
 K ^XU8P655("THEGOOD")
 K ^XU8P655("THEBAD")
 K ^XU8P655("THEUGLY")
 Q
THEUGLY(I,FLAG,MSG,XDUZ,PROV) ;Set ugly data
 S FLAG=1
 S I=I+1
 S ^XU8P655("THEUGLY",I,0)=$J($E(MSG,1,18),18)_$J($E(XDUZ,1,15),15)_" "_$J($E(PROV,1,35),35)
 Q
BULL(TYPE) ;Send local e-mail
 ; Returns: Message number
 N DIFROM,I,J,XMB,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,XUTEXT
 S XUTEXT(4)=" "
 S XUTEXT(5)="On August 7, 2014, the President signed into law PL 113-146, the Veterans"
 S XUTEXT(6)="Access, Choice, and Accountability Act of 2014 (VACAA). The law offers an"
 S XUTEXT(7)="additional authority for VHA to expand current capacity and ensure that"
 S XUTEXT(8)="Veterans have timely access to high-quality care. The law creates a new"
 S XUTEXT(9)="paradigm for providing health care, set forth in the Veterans Choice program"
 S XUTEXT(10)="provisions within Title I Section 101 of VACAA. VA is utilizing a Contractor"
 S XUTEXT(11)="to provide health care and third party administrative (TPA) services set forth"
 S XUTEXT(12)="through VACAA Section 101. As a result of this law, VA must upload a list of"
 S XUTEXT(13)="non-VA medical care providers into the VistA system in order to maintain an"
 S XUTEXT(14)="accurate and updated list of non-VA providers in the Choice program."
 S XUTEXT(15)=" "
 S XUTEXT(16)="Refer to the Non-VA Care Provider SharePoint site for further information:"
 S XUTEXT(17)="https://vaww.dwh.cdw.portal.domain.ext/sites/Non-VA%20Care%20PC3%20and%20Choice/SitePages/Home.aspx"
 S XUTEXT(18)=" "
 S I=0,J=21
 I TYPE="THEGOOD" D
 . S XMSUB="XU*8.0*655: The Good"
 . S XUTEXT(1)="This message lists Non-VA Providers successfully uploaded into the VISTA"
 . S XUTEXT(2)="NEW PERSON file (#200) for VACAA (described below)."
 . S XUTEXT(3)=" "
 . S XUTEXT(19)="            DUZ                            Provider"
 . S XUTEXT(20)="            ---                            --------"
 . F  D  Q:I=""
 . . S I=$O(^XU8P655("THEGOOD",I)) Q:I=""
 . . S XUTEXT(J)=$G(^XU8P655("THEGOOD",I,0))
 . . S J=J+1
 I TYPE="THEBAD" D
 . S XMSUB="XU*8.0*655: The Bad"
 . S XUTEXT(1)="This message lists Non-VA Providers that failed to load into the VISTA"
 . S XUTEXT(2)="NEW PERSON file (#200) for VACAA (described below)."
 . S XUTEXT(3)=" "
 . S XUTEXT(19)="     Error Message                            Provider"
 . S XUTEXT(20)="     -------------                            --------"
 . F  D  Q:I=""
 . . S I=$O(^XU8P655("THEBAD",I)) Q:I=""
 . . S XUTEXT(J)=$G(^XU8P655("THEBAD",I,0))
 . . S J=J+1
 I TYPE="THEUGLY" D
 . S XMSUB="XU*8.0*655: The Ugly"
 . S XUTEXT(1)="This message lists Non-VA Providers successfully loaded into the VISTA"
 . S XUTEXT(2)="NEW PERSON file (#200) for VACAA (described below), but which may"
 . S XUTEXT(3)="require manual review due to data discrepancies."
 . S XUTEXT(19)="     Error Message            DUZ                            Provider"
 . S XUTEXT(20)="     -------------            ---                            --------"
 . F  D  Q:I=""
 . . S I=$O(^XU8P655("THEUGLY",I)) Q:I=""
 . . S XUTEXT(J)=$G(^XU8P655("THEUGLY",I,0))
 . . S J=J+1
 S XMTEXT="XUTEXT("
 S XMDUZ=DUZ
 S XMY(DUZ)=""
 S XMY("G.PATCHES")=""
 D ^XMD
 Q $G(XMZ)
