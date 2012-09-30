PXRMEXPS ; SLC/PKR - Packing save routines. ;10/28/2011
 ;;2.0;CLINICAL REMINDERS;**12,16,18,22**;Feb 04, 2005;Build 160
 ;==========================================
ADD(FILENUM,IEN,PACKLIST,NF) ;
 S NF=+$O(PACKLIST(FILENUM,"IEN"),-1)+1
 S PACKLIST(FILENUM,NF)=IEN
 S PACKLIST(FILENUM,"IEN",IEN)=NF
 Q
 ;
 ;==========================================
CHKCF(ROOT,TOPIEN,GBL,PACKLIST) ;
 N IEN,NAME,NUM,PARM
 S IEN=""
 F  S IEN=$O(@ROOT@(TOPIEN,20,"E",GBL,IEN)) Q:IEN=""  D
 . I $P($G(^PXRMD(811.4,IEN,0)),U,1)'="VA-REMINDER DEFINITION" Q
 . S NUM=$O(@ROOT@(TOPIEN,20,"E",GBL,IEN,"")) Q:NUM'>0
 . S PARM=$P($G(@ROOT@(TOPIEN,20,NUM,15)),U,1)
 . S NAME=$P(PARM,U,1)
 . S RIEN=$O(^PXD(811.9,"B",NAME,"")) Q:RIEN'>0
 . S ROUTINE=$$GETSRTN(811.9)_"(811.9,RIEN,.PACKLIST)"
 . D @ROUTINE
 Q
 ;
 ;==========================================
EXISTS(FILENUM,IEN,PACKLIST) ;If the entry already exists remove it
 ;and keep only the higher entry.
 I '$D(PACKLIST(FILENUM,"IEN",IEN)) Q
 N NUM
 S NUM=PACKLIST(FILENUM,"IEN",IEN)
 K PACKLIST(FILENUM,NUM)
 Q
 ;
 ;==========================================
GEDSUB(EDUIEN,NSUB,LIST) ;Build the recursive list of education topic
 ;subtopics.
 ;DBIA #3085
 N IND,SUBIEN
 S IND=0
 F  S IND=+$O(^AUTTEDT(EDUIEN,10,IND)) Q:IND=0  D
 . S NSUB=NSUB+1
 . S SUBIEN=$P(^AUTTEDT(EDUIEN,10,IND,0),U,1)
 . S LIST(NSUB)=SUBIEN
 . D GEDSUB(SUBIEN,.NSUB,.LIST)
 Q
 ;
 ;==========================================
GETFNUM(GBL) ;Return the file number for a global.
 S GBL="^"_GBL_"0)"
 Q +$P(@GBL,U,2)
 ;
 ;==========================================
GETSRTN(FILENUM) ;Return the save routine according to the file number.
 I FILENUM=50 Q "SGEN^PXRMEXPS"
 I FILENUM=50.6 Q "SGEN^PXRMEXPS"
 I FILENUM=50.605 Q "SGEN^PXRMEXPS"
 I FILENUM=60 Q "SLT^PXRMEXPS"
 I FILENUM=71 Q "SGEN^PXRMEXPS"
 I FILENUM=80 Q "NOSAVE^PXRMEXPS"
 I FILENUM=80.1 Q "NOSAVE^PXRMEXPS"
 I FILENUM=81 Q "NOSAVE^PXRMEXPS"
 I FILENUM=101.41 Q "SODIALOG^PXRMEXPS"
 I FILENUM=101.43 Q "SGEN^PXRMEXPS"
 I FILENUM=120.51 Q "SGEN^PXRMEXPS"
 I FILENUM=142 Q "SHST^PXRMEXPS"
 I FILENUM=142.1 Q "SGEN^PXRMEXPS"
 I FILENUM=142.5 Q "SHSO^PXRMEXPS"
 I FILENUM=601.71 Q "SGEN^PXRMEXPS"
 I FILENUM=790.404 Q "SGEN^PXRMEXPS"
 I FILENUM=801 Q "SROC^PXRMEXPS"
 I FILENUM=801.1 Q "SRULE^PXRMEXPS"
 I FILENUM=801.41 Q "SDIALOG^PXRMEXPS"
 I FILENUM=810.2 Q "SEDEF^PXRMEXPS"
 I FILENUM=810.4 Q "SLR^PXRMEXPS"
 I FILENUM=810.7 Q "SRECR^PXRMEXPS"
 I FILENUM=810.8 Q "SRCG^PXRMEXPS"
 I FILENUM=810.9 Q "SLL^PXRMEXPS"
 I FILENUM=811.2 Q "SGENR^PXRMEXPS"
 I FILENUM=811.4 Q "SCF^PXRMEXPS"
 I FILENUM=811.5 Q "SRT^PXRMEXPS"
 I FILENUM=811.6 Q "SGEN^PXRMEXPS"
 I FILENUM=811.9 Q "SDEF^PXRMEXPS"
 I FILENUM=8925.1 Q "STIUOBJ^PXRMEXPS"
 I FILENUM=8927.1 Q "STIUTEMP^PXRMEXPS"
 I FILENUM=9999999.09 Q "SED^PXRMEXPS"
 I FILENUM=9999999.14 Q "SGEN^PXRMEXPS"
 I FILENUM=9999999.15 Q "SGEN^PXRMEXPS"
 I FILENUM=9999999.28 Q "SGEN^PXRMEXPS"
 I FILENUM=9999999.64 Q "SHF^PXRMEXPS"
 Q "NORTN^PXRMEXPS"
 ;
 ;==========================================
NORTN(FILENUM,IEN,PACKLIST) ;Don't have a routine for this file number.
 S NF=+$O(PACKLIST(FILENUM,"IEN"),-1)+1
 S PACKLIST(FILENUM,NF)=IEN
 S PACKLIST(FILENUM,"IEN",IEN)=NF
 S PACKLIST(FILENUM,"ERROR",IEN)="No packing routine for file number "_FILENUM_"."
 Q
 ;
 ;==========================================
NOSAVE(FILENUM,IEN,PACKLIST) ;Don't do anything for this file number.
 Q
 ;
 ;==========================================
SCF(FILENUM,IEN,PACKLIST) ;Reminder computed findings.
 N CFRTN
 ;Add the computed finding file entry.
 D SGENR(FILENUM,IEN,.PACKLIST)
 S CFRTN=$P(^PXRMD(811.4,IEN,0),U,2)
 ;Add the routine; mark routines with file number 0.
 D SGEN(0,CFRTN,.PACKLIST)
 Q
 ;
 ;==========================================
SDEF(FILENUM,RIEN,PACKLIST) ;Reminder definitions.
 N DIALOG,ENODE,EO,FINDING,FINUM,FNUM,GBL,IEN,NF,ROUTINE,SPON
 D SGENR(FILENUM,RIEN,.PACKLIST)
 ;Process the finding multiple.
 S FINUM=0
 F  S FINUM=+$O(^PXD(811.9,RIEN,20,FINUM)) Q:FINUM=0  D
 . S FINDING=$P(^PXD(811.9,RIEN,20,FINUM,0),U,1)
 . S IEN=$P(FINDING,";",1)
 . S GBL=$P(FINDING,";",2)
 . S FNUM=$$GETFNUM(GBL)
 . I FNUM=811.4 D CHKCF("^PXD(811.9)",RIEN,GBL,.PACKLIST)
 . S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,IEN,.PACKLIST)"
 . D @ROUTINE
 ;Dialog
 S DIALOG=+$G(^PXD(811.9,RIEN,51))
 I DIALOG>0,'$D(PACKLIST(801.41,"IEN",DIALOG)) D SDIALOG(801.41,DIALOG,.PACKLIST)
 Q
 ;
 ;==========================================
SDIALOG(FILENUM,DIEN,PACKLIST) ;Reminder dialogs.
 I DIEN'>0 Q
 N IEN,IND,FI,FNUM,GBL,MHT,OI,OLIST,REG,ROUTINE,TEMP,TERM,TLIST
 D SGENR(FILENUM,DIEN,.PACKLIST)
 ;Get the source reminder.
 S IEN=$P(^PXRMD(801.41,DIEN,0),U,2)
 I IEN'="" D
 . S ROUTINE=$$GETSRTN(811.9)_"(811.9,IEN,.PACKLIST)"
 . D @ROUTINE
 ;Check for a finding item.
 S TEMP=$G(^PXRMD(801.41,DIEN,1))
 S FI=$P(TEMP,U,5)
 I FI'="" D
 . S IEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S FNUM=$$GETFNUM(GBL)
 . S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,IEN,.PACKLIST)"
 . D @ROUTINE
 ;Check for an orderable item.
 S OI=$P(TEMP,U,7)
 I OI'="" D
 . S ROUTINE=$$GETSRTN(101.43)_"(101.43,OI,.PACKLIST)"
 . D @ROUTINE
 ;Check for additional findings.
 S IND=0
 F  S IND=+$O(^PXRMD(801.41,DIEN,3,IND)) Q:IND=0  D
 . S FI=$P(^PXRMD(801.41,DIEN,3,IND,0),U,1)
 . S IEN=$P(FI,";",1)
 . S GBL=$P(FI,";",2)
 . S FNUM=$$GETFNUM(GBL)
 . S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,IEN,.PACKLIST)"
 . D @ROUTINE
 ;Check word processing fields for TIU Object and Template Fields
 D TIUSRCH^PXRMEXU1("^PXRMD(801.41,",DIEN,25,.OLIST,.TLIST)
 I $D(OLIST)>0 D
 . S ROUTINE=$$GETSRTN(8925.1)_"(8925.1,.OLIST,.PACKLIST)"
 . D @ROUTINE K OLIST
 I $D(TLIST)>0 D
 . S ROUTINE=$$GETSRTN(8927.1)_"(8927.1,.TLIST,.PACKLIST)"
 . D @ROUTINE K TLIST
 D TIUSRCH^PXRMEXU1("^PXRMD(801.41,",DIEN,35,.OLIST,.TLIST)
 I $D(OLIST)>0 D
 . S ROUTINE=$$GETSRTN(8925.1)_"(8925.1,.OLIST,.PACKLIST)"
 . D @ROUTINE K OLIST
 I $D(TLIST)>0 D
 . S ROUTINE=$$GETSRTN(8927.1)_"(8927.1,.TLIST,.PACKLIST)"
 . D @ROUTINE K TLIST
 ;Check the components multiple for elements.
 I $D(^PXRMD(801.41,DIEN,10)) D
 . S ROUTINE=$$GETSRTN(801.41)_"(801.41,IEN,.PACKLIST)"
 . S IND=0
 . F  S IND=+$O(^PXRMD(801.41,DIEN,10,IND)) Q:IND=0  D
 .. S IEN=$P(^PXRMD(801.41,DIEN,10,IND,0),U,2)
 .. D @ROUTINE
 ;Check for a term and a replacement element/group.
 S TEMP=$G(^PXRMD(801.41,DIEN,49))
 S TERM=$P(TEMP,U,1)
 I TERM'="" D
 . S ROUTINE=$$GETSRTN(811.5)_"(811.5,TERM,.PACKLIST)"
 . D @ROUTINE
 S REG=$P(TEMP,U,3)
 I REG'="" D
 . S ROUTINE=$$GETSRTN(801.41)_"(801.41,REG,.PACKLIST)"
 . D @ROUTINE
 ;Check for a mental health test.
 S MHT=$P($G(^PXRMD(801.41,DIEN,50)),U,1)
 I MHT'="" D
 . S ROUTINE=$$GETSRTN(601.71)_"(601.71,MHT,.PACKLIST)"
 . D @ROUTINE
 ;Check for result groups.
 I $D(^PXRMD(801.41,DIEN,51)) D
 . S ROUTINE=$$GETSRTN(801.41)_"(801.41,IEN,.PACKLIST)"
 . S IND=0
 . F  S IND=+$O(^PXRMD(801.41,DIEN,51,IND)) Q:IND=0  D
 .. S IEN=$P(^PXRMD(801.41,DIEN,51,IND,0),U,1)
 .. D @ROUTINE
 Q
 ;
 ;==========================================
SED(FILENUM,IEN,PACKLIST) ;Education topics.
 N IND,NF,NSUB,SUBLIST
 D EXISTS(FILENUM,IEN,.PACKLIST)
 D ADD(FILENUM,IEN,.PACKLIST,.NF)
 S NSUB=0
 ;Get all the subtopics.
 D GEDSUB(IEN,.NSUB,.SUBLIST)
 F IND=1:1:NSUB D
 . D EXISTS(FILENUM,SUBLIST(IND),.PACKLIST)
 . S NF=NF+1
 . S PACKLIST(FILENUM,NF)=SUBLIST(IND)
 . S PACKLIST(FILENUM,"IEN",SUBLIST(IND))=NF
 Q
 ;
 ;==========================================
SEDEF(FILENUM,IEN,PACKLIST) ;Reminder extract definitions.
 N CR,CRRTN,IND,JND,LRRTN,LRS,RDEF,RDEFRTN,TEMP
 D SGEN(FILENUM,IEN,.PACKLIST)
 ;Initialize the save routines.
 S LRRTN=$$GETSRTN(810.4)_"(810.4,LRS,.PACKLIST)"
 S CRRTN=$$GETSRTN(810.7)_"(810.7,CR,.PACKLIST)"
 S RDEFRTN=$$GETSRTN(811.9)_"(811.9,RDEF,.PACKLIST)"
 ;Go through the extract sequence.
 S IND=0
 F  S IND=+$O(^PXRM(810.2,IEN,10,IND)) Q:IND=0  D
 . S LRS=$P(^PXRM(810.2,IEN,10,IND,0),U,2)
 . D @LRRTN
 .;Go through the reminders and counting rules.
 . S JND=0
 . F  S JND=+$O(^PXRM(810.2,IEN,10,IND,10,JND)) Q:JND=0  D
 .. S TEMP=^PXRM(810.2,IEN,10,IND,10,JND,0)
 .. S RDEF=$P(TEMP,U,2)
 .. I RDEF'="" D @RDEFRTN
 .. S CR=$P(TEMP,U,3)
 .. I CR'="" D @CRRTN
 Q
 ;
 ;==========================================
SGEN(FILENUM,IEN,PACKLIST) ;General save routine, used for everything that
 ;does not require special handling.
 N NF
 D EXISTS(FILENUM,IEN,.PACKLIST)
 D ADD(FILENUM,IEN,.PACKLIST,.NF)
 Q
 ;
 ;==========================================
SGENR(FILENUM,IEN,PACKLIST) ;General reminder global save routine, used for
 ;reminder globals that do not require special handling.
 N SPON
 D SGEN(FILENUM,IEN,.PACKLIST)
 S SPON=+$$GET1^DIQ(FILENUM,IEN,101,"I")
 I SPON>0 D SGEN(811.6,SPON,.PACKLIST)
 Q
 ;
 ;==========================================
SHF(FILENUM,IEN,PACKLIST) ;Health factors.
 N CAT,HF,NF
 ;All health factor references covered by DBIA #3083.
 ;If the health factor is a category then it has to be coming from
 ;a health summary so include all the health factors in the category.
 I $P(^AUTTHF(IEN,0),U,10)="C" D
 . S CAT=1,HF=0
 . F  S HF=$O(^AUTTHF("AC",IEN,HF)) Q:HF'>0  D
 .. D EXISTS(FILENUM,HF,.PACKLIST)
 .. D ADD(FILENUM,HF,.PACKLIST,.NF)
 D EXISTS(FILENUM,IEN,.PACKLIST)
 D ADD(FILENUM,IEN,.PACKLIST,.NF)
 I $G(CAT) Q
 ;For a regular health factor make sure the category is on the list.
 S CAT=$P(^AUTTHF(IEN,0),U,3)
 D EXISTS(FILENUM,CAT,.PACKLIST)
 S NF=NF+1
 S PACKLIST(FILENUM,NF)=CAT
 S PACKLIST(FILENUM,"IEN",CAT)=NF
 Q
 ;
 ;==========================================
SHSO(FILENUM,IEN,PACKLIST) ;Health summary object.
 N HST
 D SGEN(FILENUM,IEN,.PACKLIST)
 S HST=$P($G(^GMT(142.5,IEN,0)),U,3)
 S ROUTINE=$$GETSRTN(142)_"(142,HST,.PACKLIST)"
 D @ROUTINE
 Q
 ;
 ;==========================================
SHST(FILENUM,IEN,PACKLIST) ;Health Summary Type
 N CNT,FNUM,GBL,HSC,ITEM,NODE,ROUTINE,SEL
 D SGEN(FILENUM,IEN,.PACKLIST)
 S CNT=0 F  S CNT=$O(^GMT(142,IEN,1,CNT)) Q:CNT'>0  D
 .S HSC=$P($G(^GMT(142,IEN,1,CNT,0)),U,2)
 .S ROUTINE=$$GETSRTN(142.1)_"(142.1,HSC,.PACKLIST)"
 .D @ROUTINE
 .;Loop through selection item, variable pointer
 .S SEL=0 F  S SEL=$O(^GMT(142,IEN,1,CNT,1,SEL)) Q:SEL'>0  D
 ..S NODE=$P($G(^GMT(142,IEN,1,CNT,1,SEL,0)),U)
 ..I NODE'="" D
 ...S ITEM=$P(NODE,";",1)
 ...S GBL=$P(NODE,";",2)
 ...S FNUM=$$GETFNUM(GBL)
 ...S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,ITEM,.PACKLIST)"
 ...I ROUTINE="NOROUTINE" Q
 ...D @ROUTINE
 Q
 ;
 ;==========================================
SLL(FILENUM,IEN,PACKLIST) ;Reminder location lists.
 N CSTEXL,IND,ROUTINE
 D SGEN(FILENUM,IEN,.PACKLIST)
 ;If CREDIT STOPS TO EXCLUDE (LIST) has been used put it on the packing
 ;list.
 S IND=0
 F  S IND=+$O(^PXRMD(810.9,IEN,40.7,IND)) Q:IND=0  D
 . S CSTEXL=$G(^PXRMD(810.9,IEN,40.7,IND,2))
 . I CSTEXL="" Q
 . S ROUTINE=$$GETSRTN(810.9)_"(810.9,CSTEXL,.PACKLIST)"
 . D @ROUTINE
 ;Save information about hospital locations which are non-transportable.
 I $D(^PXRMD(810.9,IEN,44))>1 D NTHLOC^PXRMEXFI(IEN,"LOCATION LIST")
 Q
 ;
 ;==========================================
SLR(FILENUM,IEN,PACKLIST) ;Reminder list rules.
 N IND,LR,RDEF,RTERM,ROUTINE,TEMP
 D SGEN(FILENUM,IEN,.PACKLIST)
 S TEMP=^PXRM(810.4,IEN,0)
 S RTERM=$P(TEMP,U,7)
 I RTERM'="" D
 . S ROUTINE=$$GETSRTN(811.5)_"(811.5,RTERM,.PACKLIST)"
 . D @ROUTINE
 S RDEF=$P(TEMP,U,10)
 I RDEF'="" D
 . S ROUTINE=$$GETSRTN(811.9)_"(811.9,RDEF,.PACKLIST)"
 . D @ROUTINE
 ;If there is a sequence save the list rules.
 I '$D(^PXRM(810.4,IEN,30)) Q
 S ROUTINE=$$GETSRTN(810.4)_"(810.4,LR,.PACKLIST)"
 S IND=0
 F  S IND=+$O(^PXRM(810.4,IEN,30,IND)) Q:IND=0  D
 . S LR=$P(^PXRM(810.4,IEN,30,IND,0),U,2)
 . D @ROUTINE
 Q
 ;
 ;==========================================
SLT(FILENUM,IEN,PACKLIST) ;Lab tests
 I +IEN'=IEN S IEN=$P(IEN,";",3)
 D SGEN(FILENUM,IEN,.PACKLIST)
 Q
 ;
 ;==========================================
SODIALOG(FILENUM,IEN,PACKLIST) ;Order dialogs.
 D SGEN(FILENUM,IEN,.PACKLIST)
 ;DBIA 5446
 D EN^ORORDDSC(IEN,"ORDER DIALOG")
 Q
 ;
 ;==========================================
SRCG(FILENUM,IEN,PACKLIST) ;Reminder counting groups.
 N IND,ROUTINE,TIEN
 D SGEN(FILENUM,IEN,.PACKLIST)
 ;Put terms on the pack list.
 S ROUTINE=$$GETSRTN(811.5)_"(811.5,TIEN,.PACKLIST)"
 S IND=0
 F  S IND=+$O(^PXRM(810.8,IEN,10,IND)) Q:IND=0  D
 . S TIEN=$P(^PXRM(810.8,IEN,10,IND,0),U,2)
 . D @ROUTINE
 Q
 ;
 ;==========================================
SRECR(FILENUM,IEN,PACKLIST) ;Reminder extract counting rule.
 N CGIEN,IND,ROUTINE,TIEN
 D SGEN(FILENUM,IEN,.PACKLIST)
 ;Put counting groups on the pack list.
 S ROUTINE=$$GETSRTN(810.8)_"(810.8,CGIEN,.PACKLIST)"
 S IND=0
 F  S IND=+$O(^PXRM(810.7,IEN,10,IND)) Q:IND=0  D
 . S CGIEN=$P(^PXRM(810.7,IEN,10,IND,0),U,2)
 . D @ROUTINE
 Q
 ;
 ;==========================================
SRT(FILENUM,TIEN,PACKLIST) ;Reminder terms.
 N FNUM,GBL,IEN,NF,ROUTINE,SPON
 N ITEM,NUM,RIEN
 D EXISTS(FILENUM,TIEN,.PACKLIST)
 D ADD(FILENUM,TIEN,.PACKLIST,.NF)
 ;Process the finding multiple.
 S GBL=""
 F  S GBL=$O(^PXRMD(811.5,TIEN,20,"E",GBL)) Q:GBL=""  D
 . S FNUM=$$GETFNUM(GBL)
 . I FNUM=811.4 D CHKCF("^PXRMD(811.5)",TIEN,GBL,.PACKLIST)
 . S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,IEN,.PACKLIST)"
 . S IEN=""
 . F  S IEN=$O(^PXRMD(811.5,TIEN,20,"E",GBL,IEN)) Q:IEN=""  D @ROUTINE
 ;Sponsor
 S SPON=+$P(^PXRMD(811.5,TIEN,100),U,2)
 I SPON>0 D SGEN(811.6,SPON,.PACKLIST)
 Q
 ;
 ;==========================================
SROC(FILENUM,ROCIEN,PACKLIST) ;Reminder Order Checks.
 ;packed order check structure up
 D SGENR(FILENUM,ROCIEN,.PACKLIST)
 N GBL,SUB,DRCL,FNUM,OI,OLIST,PHAR,RIEN,ROUTINE,TIEN,TLIST,WPNODE
 ;Process the pharmacy multiple.
 S PHAR=""
 F  S PHAR=$O(^PXD(801,ROCIEN,1.5,"B",PHAR)) Q:PHAR=""  D
 . S IEN=$P(PHAR,";"),GBL=$P(PHAR,";",2)
 . S FNUM=$$GETFNUM(GBL)
 . S ROUTINE=$$GETSRTN(FNUM)_"(FNUM,IEN,.PACKLIST)"
 . D @ROUTINE
 ;packed list of Orderable Item
 I $D(^PXD(801,ROCIEN,2)) D
 .S SUB=0 F  S SUB=$O(^PXD(801,ROCIEN,2,SUB)) Q:SUB'>0  D
 ..S OI=$P($G(^PXD(801,ROCIEN,2,SUB,0)),U) Q:OI'>0
 ..S ROUTINE=$$GETSRTN(101.43)_"(101.43,OI,.PACKLIST)"
 ..D @ROUTINE
 ;loop through rules and packed definitions or terms
 S SUB=0 F  S SUB=$O(^PXD(801,ROCIEN,3,SUB)) Q:SUB'>0  D
 .S RIEN=$P($G(^PXD(801,ROCIEN,3,SUB,0)),U) Q:RIEN'>0
 .S ROUTINE=$$GETSRTN(801.1)_"(801.1,RIEN,.PACKLIST)"
 .D @ROUTINE
 Q
 ;
 ;==========================================
SRULE(FILENUM,RULEIEN,PACKLIST) ;Reminder Order Check Rules.
 ;packed order check structure up
 D SGENR(FILENUM,RULEIEN,.PACKLIST)
 N OLIST,RIEN,ROUTINE,TIEN,TLIST
 I $D(^PXD(801.1,RULEIEN,3,4))>0 D
 .;search for TIU Objects
 .D TIUSRCH^PXRMEXU1("^PXD(801.1,",RULEIEN,",4",.OLIST,.TLIST)
 .I $D(OLIST)>0 D
 ..S ROUTINE=$$GETSRTN(8925.1)_"(8925.1,.OLIST,.PACKLIST)"
 ..D @ROUTINE K OLIST
 .K TLIST
 .;packed term up only
 S TIEN=$P($G(^PXD(801.1,RULEIEN,2)),U) I TIEN>0 D  Q
 .S ROUTINE=$$GETSRTN(811.5)_"(811.5,TIEN,.PACKLIST)"
 .D @ROUTINE
 ;packed definition up if defined
 S RIEN=$P($G(^PXD(801.1,RULEIEN,3)),U) I RIEN>0 D
 .S ROUTINE=$$GETSRTN(811.9)_"(811.9,RIEN,.PACKLIST)"
 .D @ROUTINE
 Q
 ;
 ;==========================================
STIUOBJ(FILENUM,OLIST,PACKLIST) ;
 N ARY,CNT,HSO,IEN,NAME,ROUTINE,TEMP
 S CNT=0 F  S CNT=$O(OLIST(CNT)) Q:CNT'>0  D
 . S NAME=OLIST(CNT)
 . ;DBIA 5447
 . S IEN=$$OBJBYNAM^TIUCHECK(.ARY,NAME) I IEN=-1 Q
 .;Do not ship non TIU/HS Objects
 . I $G(ARY(IEN,9))'["S X=$$TIU^GMTSOBJ(" D  Q
 .. D TIU^PXRMEXU5(IEN,.ARY,"TIU OBJECT")
 .. D SGEN(FILENUM,IEN,.PACKLIST)
 . D SGEN(FILENUM,IEN,.PACKLIST)
 . S TEMP=$P($G(ARY(IEN,9)),",",2)
 . S HSO=$P(TEMP,")")
 . S ROUTINE=$$GETSRTN(142.5)_"(142.5,.HSO,.PACKLIST)"
 . D @ROUTINE
 Q
 ;
 ;==========================================
STIUTEMP(FILENUM,TLIST,PACKLIST) ;
 N CNT,IEN,NAME
 S CNT=0 F  S CNT=$O(TLIST(CNT)) Q:CNT'>0  D
 .S NAME=TLIST(CNT)
 .S IEN=$O(^TIU(8927.1,"B",NAME,"")) Q:IEN'>0
 .D SGEN(FILENUM,IEN,.PACKLIST)
 Q
 ;
