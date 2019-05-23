IBCU75 ;ALB/JRA - INTERCEPT SCREEN INPUT OF PROCEDURE CODES (ENTER CMN INFO) ;23-Apr-18
 ;;2.0;INTEGRATED BILLING;**608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CMN(IBXIEN,IBPROCP) ;JRA;IB*2.0*608 Prompt user for CMN info
 ;Input: IBXIEN  = Internal bill/claim number
 ;       IBPROCP = Procedure line subscript in ^DGCR
 ;
 Q:('$G(IBXIEN)!('$G(IBPROCP)))
 N ABGMSG,ABGPO2,CERTDT,CERTYP,CHNGFRM,CMNNODE,CMNREQ,CMSG,DA,DIC,DIE,DIR,DGLB,DR,DRTAG,DTOLD,EDIT,EVNTDT,FIEN,FNAM,FORM,FRMTAG
 N FRMTYP,HT,HTOLD,I,IBPEB,WTOLD,LKGLB,LPM4ABG,LPM4SAT,MSG,NODE0,O2SAT,OK,OLDVAL,PROCA,PROCB,QUIT,RRDT,TDY,THERPYDT,X,Y
 S DGLB="^TMP(""CMN"",$J)" K @DGLB
 S LKGLB="^DGCR(399,"_IBXIEN_")" L +@LKGLB:0 I '$T W !,$C(7),"Another user is editing this entry -- EXITING" H 2 Q
 S EVNTDT=$$FMTE^DILIBF($G(IBDT),"5U")  ;Get the Event Date - will be the default for several date fields.
 S TDY=$$HTFM^DILIBF(+$H)
 S ABGMSG="""ABG PO2"" and/or ""O2 Saturation"" Test(s) REQUIRED"
 S DA=IBPROCP,DA(1)=IBXIEN,DIE="^DGCR(399,"_IBXIEN_",""CP"","
 ;Set FORM array of CMN Data Nodes (D399.6 field 3) indexed by CMN Form Type ien
 S FNAM="" F  S FNAM=$O(^IBE(399.6,"B",FNAM)) Q:FNAM=""  S FIEN=+$O(^IBE(399.6,"B",FNAM,"")) I FIEN D
 . S FORM(FIEN)=$P($G(^IBE(399.6,FIEN,0)),U,4) K:$TR(FORM(FIEN)," ")="" FORM(FIEN)
 I $D(FORM)'>1 S FORM(1)="CMN-484",FORM(2)="CMN-10126"  ;Default nodes for CMN data
 S DIE("NO^")="BACKOUTOK"
 S CMNREQ("MSG")="If ""CMN Required?"" is changed to ""NO"", existing CMN data will be deleted!"
 S FRMTYP("MSG")="Changing the Form Type will delete any data specific to the current Form Type!"
 S CERTYP("MSG")="You are changing the Certification Type!"
 S CERTYP("MSGI")="Changing Certification Type to ""I"" will delete ""Recertification/Revision Date!"""
 D CMNREQ
 S QUIT=0 F  D  Q:QUIT
 . D ^DIE
 . S CMNREQ=$G(CMNREQ),FRMTYP=$G(FRMTYP),CERTYP=$G(CERTYP)
 . S CMNREQ=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,23,"I") I CMNREQ=0 S QUIT=1 Q
 . S FRMTYP=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24,"I")
 . S CERTYP=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.01,"I")
 . I FRMTYP,CERTYP'="" S QUIT=1 Q
 . I CMNREQ="" W $C(7),!,?3,"""CMN Required?"" is a REQUIRED field!" D CMNREQ Q
 . S MSG=""
 . I FRMTYP="" S MSG="""Form Type"" and ""Certification Type"" are REQUIRED!",DRTAG="CMNREQ"
 . E  I CERTYP="" S MSG="""Certification Type"" is REQUIRED!",DRTAG="CMNREQ"
 . I MSG]"" S DR="",MSG=MSG_$C(13,10)_"   ** To exit, set ""CMN Required?"" to ""NO""" W $C(7),!,?3,MSG D @DRTAG Q
 . S QUIT=1
 ;
 ;If CMN is not required, delete all CMN data that may be associated with this procedure & exit
 I $G(CMNREQ)=0 D  Q
 . S FIEN="" F  S FIEN=$O(FORM(FIEN)) Q:FIEN=""  I FORM(FIEN)]"" D
 . . S CMNNODE="^DGCR(399,"_IBXIEN_",""CP"","_IBPROCP_","""_FORM(FIEN)_""")" K @CMNNODE
 . S CMNNODE="^DGCR(399,"_IBXIEN_",""CP"","_IBPROCP_",""CMN"")" K @CMNNODE S @CMNNODE=0
 ;
 ;If user selected Form Type we need to remove data that may exist for any other Form Type.
 I $G(FRMTYP) S FIEN="" F  S FIEN=$O(FORM(FIEN)) Q:FIEN=""  I FIEN'=FRMTYP D
 . S CMNNODE="^DGCR(399,"_IBXIEN_",""CP"","_IBPROCP_","""_FORM(FIEN)_""")" K @CMNNODE
 ;
 I $G(CERTYP)="I" D SETFLD(24.07,"@")  ;If "Certification Type" is "INITIAL" delete "Recertification/Revision Date"
 ;
 I (($D(EDIT)&($G(EDIT)'="Y"))!(X=""!('$G(CMNREQ)!('$G(FRMTYP)!($G(CERTYP)=""))))) Q
 ;
 S FRMTAG="DR"_$S($G(FORM(FRMTYP))[484:484,1:10126)  ;Set tag to call to set DR with form-specific logic
 D DRCOMM
 ;
 ;Prompt user for remaining questions & check for missing required fields
 S (QUIT,UPCT)=0,DRTAG(1)="" F  D  Q:QUIT
 . D ^DIE
 . K MSG S MSG=0
 . S DRTAG=""
 . S CERTYP=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.01,"I")
 . S HT=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.02,"I")
 . S THERPYDT=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.05,"I")
 . S CERTDT=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.06,"I")
 . S RRDT=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.07,"I")
 . I 'CERTDT S MSG=MSG+1,MSG(MSG)="""Last Certification Date""" S DRTAG="DRCOMM"
 . I 'RRDT,CERTYP'="I" S MSG=MSG+1,MSG(MSG)="""Recertification/Revision Date""" S:DRTAG="" DRTAG="RRDT"
 . I 'THERPYDT S MSG=MSG+1,MSG(MSG)="""Date Therapy Started""" S:DRTAG="" DRTAG="STRTDT"
 . I FORM(FRMTYP)[10126 D
 . . I $$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.217,"I")="" S MSG=MSG+1,MSG(MSG)="""Is this for Parenteral nutrition, Enteral nutrition, or Both?""" S:DRTAG="" DRTAG="DR10126"
 . I +MSG D  Q
 . . S:X="" UPCT=UPCT+1 I UPCT>1,DRTAG=DRTAG(1) S QUIT=1 Q
 . . S DR="" W $C(7) F I=1:1:MSG W !,?3,MSG(I)_" is REQUIRED!"
 . . W !,?3,"** Exiting now will leave required fields unanswered."
 . . W !,?3,"** If you must exit, enter '^' again."
 . . S DRTAG(1)=DRTAG D @DRTAG
 . S QUIT=1
 ;
 ;Delete dates associated with result fields that were deleted
 I $D(@DGLB)>1 D
 . N FLD
 . S FLD="" F  S FLD=$O(@DGLB@(FLD)) Q:FLD=""  D SETFLD(FLD,"@")
 . K @DGLB
 Q
 ;
CMNREQ ; Set DR with logic for 1st 3 fields: "CMN Required?", "Form Type" and "Certification Type"
 S DR="@23;S CMNREQ(""OLD"")=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,23,""I"");23R~T//NO;S CMNREQ=X I 'X,'CMNREQ(""OLD"") S Y=""@999"";"
 S DR=DR_"I CMNREQ=0,CMNREQ(""OLD"")=1 S FRM=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24,""I"") S:'FRM OK=1 S:FRM OK=$$USEROK^IBCU75(23,1,CMNREQ(""MSG""))"
 S DR=DR_" S:OK Y=""@999"" I 'OK S Y=""@23"";"
FRMTYP ;Entry point to set DR with logic for "Form Type" and "Certification Type" fields in preparation for re-prompting.
 S DR=DR_"@24;S DIC(0)=""N"" S FRMTYP(""OLD"")=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24,""I"");24R~T;S FRMTYP=X I FRMTYP(""OLD"")]"""",FRMTYP]"""""
 S DR=DR_",FRMTYP'=FRMTYP(""OLD"") S OK=$$USEROK^IBCU75(24,FRMTYP(""OLD""),FRMTYP(""MSG"")) S:OK CHNGFRM=1 S:'OK Y=""@24"";"
 S DR=DR_"I $G(CHNGFRM)!($$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.01,""I"")="""") D COPYCMN^IBCU75(IBXIEN,IBPROCP,FRMTYP);"
 S DR=DR_"I $$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.01,""I"")]"""",'$G(CHNGFRM) R !,""Edit CMN Information for this Procedure? NO// "",EDIT S EDIT=$E($ZCONVERT(EDIT,""U"")) "
 S DR=DR_"W:(EDIT]""""&(EDIT'=""^"")) ""  ""_$S(EDIT=""Y"":""YES"",1:""NO"") I EDIT'=""Y"" S Y=""@999"";"
CERTYP ;Entry point to set DR with logic for "Certification Type" field in preparation for re-prompting.
 S DR=DR_"@01;S CERTYP(""OLD"")=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.01,""I"");24.01R~T//INITIAL"
 S DR=DR_";S CERTYP=X I CERTYP(""OLD"")]"""",CERTYP]"""",CERTYP'=CERTYP(""OLD"")"
 S DR=DR_" S CMSG=$S(CERTYP=""I"":CERTYP(""MSGI""),1:CERTYP(""MSG""))"
 S DR=DR_" S OK=$$USEROK^IBCU75(24.01,CERTYP(""OLD""),CMSG) S:'OK Y=""@01"";@999;"
 Q
 ;
DRCOMM ;Set DR with logic for the remaining fields common to all form types
 S DR="@06;S DTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.06,""I"");24.06R~T//"_EVNTDT_";D DTCHK^IBCU75(X,TDY,""06"",$G(DTOLD));"
 S DR=DR_"I CERTYP=""I"" S @DGLB@(24.07)="""",Y=""@02"";"
RRDT ;Entry point to set DR with logic for "Recertification/Revision Date"... fields in preparation for re-prompting.
 S DR=DR_"@07;S DTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.07,""I"");24.07R~T//"_EVNTDT_";D DTCHK^IBCU75(X,TDY,""07"",$G(DTOLD));"
 S DR=DR_"@02;S HTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.02,""I"");24.02T;I X>96 S OK=$$USEROK^IBCU75(24.02,HTOLD,""Patient is over 8 feet tall!"")"
 S DR=DR_" I 'OK S Y=""@02"";@03;S WTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.03,""I"");24.03T;I X>500 S OK=$$USEROK^IBCU75(24.03,WTOLD,"
 S DR=DR_"""Patient is over 500 pounds!"") I 'OK S Y=""@03"";24.04T;"
STRTDT ;Entry point to set DR with logic for "Date Therapy Started"... fields in preparation for re-prompting.
 S DR=DR_"@05;S DTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.05,""I"");24.05R~T//"_EVNTDT_";D DTCHK^IBCU75(X,TDY,""05"",$G(DTOLD));@08;24.08T//N;"
 D @FRMTAG
 Q
 ;
DR484 ;Set DR with logic specific for form CMN-484
 S DR=DR_"@100;24.1T;S ABGPO2=X;@102;24.102T;S O2SAT=X;I ABGPO2="""",O2SAT="""" S Y=""@104"";"
 S DR=DR_"@103;S DTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.103,""I"");24.103T;D DTCHK^IBCU75(X,TDY,103,$G(DTOLD));"
 S DR=DR_"@104;I (ABGPO2<56!(ABGPO2>59)),(O2SAT'=89) S @DGLB@(24.104)="""",@DGLB@(24.105)="""""
 S DR=DR_",@DGLB@(24.106)="""",Y=""@107"";24.104T//NO;24.105T//NO;24.106T//NO;@107;24.107T;24.108T;24.109T;24.11T;I X'>4 S @DGLB@(24.111)="""""
 S DR=DR_",@DGLB@(24.113)="""",@DGLB@(24.114)="""",Y=""@115"";24.111T;S ABG4LPM=X;"
 S DR=DR_"@113;24.113T;I 'ABG4LPM,'X S Y=""@115"",@DGLB@(24.114)="""";"
 S DR=DR_"@114;S DTOLD=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.114,""I"");24.114T;D DTCHK^IBCU75(X,TDY,114,$G(DTOLD));@115;24.115T;@999;"
 Q
 ;
DR10126 ;Set DR with logic specific to the CMN-10126
 S DR=DR_"@217;S IBPEB(""OLD"")=$$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.217,""I"");24.217R~T//P;S IBPEB=X I IBPEB(""OLD"")]"""",IBPEB]"""",IBPEB(""OLD"")'=IBPEB "
 S DR=DR_"S OK=$$USEROK^IBCU75(24.217,IBPEB(""OLD""),""You are changing the nutrition type!"") S:'OK Y=""@217"";I $G(IBPEB)=""P"" S Y=""@206"" "
 S DR=DR_"N I F I=24.201:.001:24.205,24.218,24.219 S @DGLB@(I)="""";24.201T;24.202T;"
 S DR=DR_"24.204T;I '+X S Y=""@205"",@DGLB@(24.203)="""" I $$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.219)]"""" S Y=""@219"";"
 S DR=DR_"24.203T;I '+X S Y=""@205"" I $$CMNDATA^IBCEF31(IBXIEN,IBPROCP,24.219)]"""" S Y=""@219"";"
 S DR=DR_"@219;24.219T;I '+X S Y=""@205"",@DGLB@(24.218)="""";"
 S DR=DR_"24.218T;@205;24.205T;@206;24.206T;I $G(IBPEB)=""E"" S Y=""@999"" "
 S DR=DR_"N I F I=24.207:.001:24.216 S @DGLB@(I)="""";"
 S DR=DR_"24.207T;24.208T;24.209T;24.21T;24.211T;24.212T;24.213T;24.215T;24.216T;@214;24.214T;@999;"
 Q
 ;
COPYCMN(IBXIEN,IBPROCP,FRMTYP) ;Copy CMN information from last procedure entered that has it to current procedure
 ;Input: IBXIEN  = Internal bill/claim number
 ;       IBPROCP = Procedure line subscript
 ;       FRMTYP  = CMN Form Type ien
 ;
 N DONE
 S DONE=0
 Q:('$G(IBXIEN)!('$G(IBPROCP)!('$G(FRMTYP))))
 N FRMND,FRMNDI,IBPROC,IBXSAVE,Z
 S FRMNDI=FORM(FRMTYP)
 D CMNDEX^IBCEF31(IBXIEN,.IBXSAVE)
 S Z="" F  S Z=$O(IBXSAVE("CMNDEX",Z),-1) Q:'Z  S IBPROC=+IBXSAVE("CMNDEX",Z) I IBPROCP,IBPROC'=IBPROCP D  Q:DONE
 . Q:('$D(^DGCR(399,IBXIEN,"CP",IBPROC,"CMN"))!('$D(^DGCR(399,IBXIEN,"CP",IBPROC,FRMNDI))))
 . S FRMND=$O(^DGCR(399,IBXIEN,"CP",IBPROC,"CMN")) Q:(FRMND=""!(FRMND'=FRMNDI))
 . S ^DGCR(399,IBXIEN,"CP",IBPROCP,"CMN")=^DGCR(399,IBXIEN,"CP",IBPROC,"CMN")
 . S ^DGCR(399,IBXIEN,"CP",IBPROCP,FRMND)=^DGCR(399,IBXIEN,"CP",IBPROC,FRMND)
 . S DONE=1
 Q 
 ;
USEROK(FLD,OLDVAL,MSG) ;JRA;IB*2.0*608 Prompt user if OK to change field value
 ;Input: FLD    =  Field for which we are asking the user to confirm the change
 ;       OLDVAL =  Value of the field before user changed
 ;       MSG    =  Warning message to display to user regarding the implications of the change
 ;
 Q:'$G(FLD) 0
 N DIC,DIR,X,Y
 S OLDVAL=$G(OLDVAL)
 W $C(7) I $TR($G(MSG)," ")]"" W !,MSG
 S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="NO" D ^DIR
 I Y'=1 D SETFLD(FLD,OLDVAL)  ;Set field back to old value if user doesn't want to continue
 I Y=1 S X="^"
 Q Y
 ;
SETFLD(FLD,VAL) ;JRA;IB*2.0*608 Set/Delete field data w/out user prompting
 ;Input: FLD = Field to set/delete
 ;       VAL = Value to set FLD to (Note: '@' will delete field value)
 ;
 Q:('$G(FLD)!($G(VAL)=""))
 N DIE,DI,DL,DP,DQ,DR,X,Y
 S DIE="^DGCR(399,"_IBXIEN_",""CP"","
 S DR=FLD_"////"_VAL
 D ^DIE
 Q
 ;
DTCHK(X,TDY,TAG,DTOLD) ;JRA;IB*2.0*608 Check if future date entered by user
 ;Input:  X     = User entry for date field (internal FileMan date format)
 ;        TDY   = Today's internal FileMan date
 ;        TAG   = Field tag to jump to if user enters a future date (usually re-prompt same date)
 ;        DTOLD = The value of the date field prior to user edit
 ;
 Q:('$G(X))!('$G(TAG))
 N FLD
 S:$G(DTOLD)="" DTOLD="@"
 S:'$G(TDY) TDY=$$HTFM^DILIBF(+$H) Q:X'>TDY
 ;User entered future date so display error and change date back to previous value.
 W $C(7),!,?3,"Future dates not allowed??"
 S Y="@"_TAG
 D SETFLD("24."_TAG,DTOLD)  ;set back to prior date
 Q
 ;
