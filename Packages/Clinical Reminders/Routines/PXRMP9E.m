PXRMP9E ; SLC/KER - Environoment Check for LEX*2.0*49/PXRM+2*9 ;02/22/2007
 ;;2.0;CLINICAL REMINDERS;**9**;Feb 04, 2005;Build 4
 ;                     
 ; Local Variables not NEWed or KILLed
 ;   XPDENV
 ;                     
 ; Global Variables
 ;   None
 ;                     
 ; External References
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA 10141  $$PATCH^XPDUTL
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA 10141  BMES^XPDUTL
 ;   DBIA 10141  MES^XPDUTL
 ;                     
ENV ; LEX*2.0*49 Environment Check
 D BM(" Code Set Update message fix (Remedy Ticket 175985)"),M(" ")
 N DA,DIC,DIQ,DR,PXRMB,PXRMBLD,PXRMBLDS,PXRMERR,PXRMHF,PXRMI,PXRML,PXRMPAT,PXRMPN,PXRMREQ,PXRMS,PXRMT,PXRMU,PXRMV,PXRMVER,X
 K XPDABORT,XPDQUIT S U="^",PXRMREQ="LEX*2.0*25;LEX*2.0*27;LEX*2.0*32;LEX*2.0*46;ICD*18.0*11;ICPT*6.0*16;PXRM*2.0*4"
 S PXRMBLD="LEX*2.0*49",PXRMBLDS="LEX*2.0*49;ICD*18.0*28;ICPT*6.0*34;PXRM*2.0*9",PXRMHF="LEX_2_49.KID"
 K PXRMERR D:+($$UR)'>0 ET("User not defined (DUZ)") I $D(PXRMERR) D ABRT Q
 D:+($$SY)'>0 ET("Undefined IO variable(s)") I $D(PXRMERR) D ABRT Q
 I +($G(XPDENV))>0 D
 . D M(" Fixes the following components:")
 . D BM("   LEX*2.0*49    Protocol LEXICAL SERVICES UPDATE")
 . D M("                 Routines LEXXFI, LEXXFI7, LEXXGI, LEXXGI2, and LEXXST")
 . D BM("   ICPT*6.0*34   Protocol ICPT CODE UPDATE EVENT")
 . D M("                 Routine  ICPTAU")
 . D BM("   ICD*18.0*28   Protocol ICD CODE UPDATE EVENT")
 . D M("                 Routine  ICDUPDT")
 . D BM("   PXRM*2.0*9    Protocol PXRM CODE SET UPDATE CPT")
 . D M("                 Protocol PXRM CODE SET UPDATE ICD")
 . D M("                 Routines PXRMCSD and PXRMCSTX"),M(" ")
 D M("   Checking installed package version numbers")
 S PXRMVER=$$VERSION^XPDUTL("LEX") I +PXRMVER'>1.9999 D  D ABRT Q
 . D ET("     Required Lexicon version 2.0 not found.")
 S PXRMV="     Lexicon Utility v "_PXRMVER,PXRMV=PXRMV_$J(" ",(30-$L(PXRMV)))
 S PXRMVER=$$VERSION^XPDUTL("PXRM") I +PXRMVER'>1.9999 D  D ABRT Q
 . D ET("     Required Clinical Reminders version 2.0 not found.")
 S PXRMV=PXRMV_"     Clinical Reminders v "_PXRMVER
 D M(PXRMV) S PXRMV=""
 S PXRMVER=$$VERSION^XPDUTL("ICD") I +PXRMVER'>17.9999 D  D ABRT Q
 . D ET("     Required ICD DRG Grouper version 18.0 not found.")
 S PXRMV="     ICD DRG Grouper v "_PXRMVER,PXRMV=PXRMV_$J(" ",(30-$L(PXRMV)))
 S PXRMVER=$$VERSION^XPDUTL("ICPT") I +PXRMVER'>5.9999 D  D ABRT Q
 . D ET("     Required ICPT/HCPCS Codes version 6.0 not found.")
 S PXRMV=PXRMV_"     ICPT/HCPCS Codes v "_PXRMVER
 D M(PXRMV) S PXRMV="" K PXRMERR D BM("   Checking for required patches")
 I $L(PXRMREQ) D
 . N PXRMPAT,PXRMI,PXRMPN,PXRMV,PXRMT
 . F PXRMI=1:1 Q:'$L($P(PXRMREQ,";",PXRMI))  S PXRMPAT=$P(PXRMREQ,";",PXRMI) D
 . . S PXRMPN=$$PATCH^XPDUTL(PXRMPAT) S PXRMT="     "_PXRMPAT
 . . S:PXRMPN>0 PXRMT=PXRMT_$J(" ",(35-$L(PXRMT)))_"installed"
 . . D:PXRMPN>0 M(PXRMT) I +PXRMPN'>0 D ET((PXRMPAT_" not found, please install "_PXRMPAT_" before continuing"))
 I $D(PXRMERR) D ABRT Q
QUIT ;   Quit   Passed Environment Check - OK
 D OK
 Q
ABRT ;   Abort  Failed Environment Check, KILL the distribution
 S PXRMBLDS="LEX*2.0*49;ICD*18.0*28;ICPT*6.0*34;PXRM*2.0*9"
 D:$D(PXRMERR) ED S XPDABORT=1,XPDQUIT=1 N PXRMI
 F PXRMI=1:1 Q:'$L($P(PXRMBLDS,";",PXRMI))  S XPDQUIT($P(PXRMBLDS,";",PXRMI))=1
 K PXRMERR
 Q
CLR ;   Clear Environment
 K DA,DIC,DIQ,DR,PXRMB,PXRMBLD,PXRMBLDS,PXRMERR,PXRMHF,PXRMI,PXRML,PXRMPAT,PXRMPN,PXRMREQ,PXRMS,PXRMT,PXRMU,PXRMV,PXRMVER,X
 Q
OK ;   Environment is OK
 N PXRMI,PXRMB,PXRMS,PXRML
 S PXRMS="  Environment "_$S($L($G(PXRMHF)):("for distribution "_$G(PXRMHF)_" "),1:"")_"is ok"
 D BM(PXRMS)
 S PXRML="  This distribution contains builds:   "
 D M(" ") F PXRMI=1:1 Q:'$L($P($G(PXRMBLDS),";",PXRMI))  S PXRMB=$P($G(PXRMBLDS),";",PXRMI) D
 . S PXRMS=PXRML_PXRMB,PXRML="                                       " D:$L($G(PXRMB)) M(PXRMS)
 D M(" ")
 Q
 ;            
 ;   Individual Checks
UR(X) ;     Check User variables
 Q:'$L($G(DUZ(0))) 0
 Q:+($G(DUZ))=0!($$NOTDEF(+$G(DUZ))) 0
 Q 1
NOTDEF(PXRMI) ;     Check to see if user is defined
 N DA,DR,DIQ,PXRMU,DIC S DA=PXRMI,DR=.01,DIC=200,DIQ="PXRMU" D EN^DIQ1
 Q '$D(PXRMU)
SY(X) ;     Check System variables
 Q:'$D(IO)!('$D(IOF))!('$D(IOM))!('$D(ION))!('$D(IOSL))!('$D(IOST)) 0
 Q 1
 ;            
 ;   Messages
ET(X) ;     Error Test
 N PXRMI S PXRMI=+($G(PXRMERR(0))),PXRMI=PXRMI+1,PXRMERR(PXRMI)="    "_$G(X),PXRMERR(0)=PXRMI
 Q
ED ;     Error Display
 N PXRMI S PXRMI=0 F  S PXRMI=$O(PXRMERR(PXRMI)) Q:+PXRMI=0  D M(PXRMERR(PXRMI))
 D M(" ") K PXRMERR Q
BM(X) ;     Blank Line with Message
 D BMES^XPDUTL($G(X)) Q
M(X) ;     Message
 D MES^XPDUTL($G(X)) Q
