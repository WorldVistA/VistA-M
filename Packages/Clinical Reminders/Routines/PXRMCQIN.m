PXRMCQIN ;SLC/PKR - Clinical quality measure inquiry for general use. ;11/19/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;==========================================
BMINQALL ;Clinical quality measure inquiry, return the formatted text OUTPUT.
 N BOP,INQTYPE,MIEN,NAME,OUTPUT
 S INQTYPE=$$GTYPE
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 S NAME=""
 F  S NAME=$O(^PXRM(802.3,"B",NAME)) Q:NAME=""  D
 . S MIEN=$O(^PXRM(802.3,"B",NAME,""))
 . D CQMINQ(INQTYPE,MIEN,.OUTPUT)
 . I BOP="B" D BROWSE^DDBR("OUTPUT","NR","Clinical Quality Measure Inquiry")
 . I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;==========================================
BMINQ(MIEN) ;Display a clinical quality measure inquiry, defaults to the Browswer.
 N BOP,DIR0,INQTYPE,OUTPUT,TITLE
 I '$D(^PXRM(802.3,MIEN)) Q
 S INQTYPE=$$GTYPE
 S TITLE="Clinical Quality Measure Inquiry - "_$S(INQTYPE="C":"Condensed",INQTYPE="F":"Full",1:"")
 D CQMINQ(INQTYPE,MIEN,.OUTPUT)
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 I BOP="B" D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;==========================================
CQMINQ(INQTYPE,MIEN,OUTPUT) ;Clinical quality measure inquiry, return the
 ;formatted text OUTPUT. Use 80 column output.
 N CHDR,CODESYSN,CODESYSP,DUPL,IENSTR,IND,OCL,NL
 N LEXSAB,MNAME,NCODES,NCODESA,NCS,NOUT,NPAD,NUCODES,RM
 N TCODES,TEMP,TERM,TEXT,TEXTOUT
 S RM=80
 D MHDR(RM,IEN,.NL,.OUTPUT)
 I INQTYPE="F" D MLISTF(MIEN,.NL,.OUTPUT)
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Value sets used in this measure:"
 I INQTYPE="C" D VSLISTC(MIEN,.NL,.OUTPUT)
 I INQTYPE="F" D VSLISTF(MIEN,.NL,.OUTPUT)
 Q
 ;
 ;==========================================
GTYPE() ;Prompt the user for the type of output.
 N DIR,POP,X,Y
 S DIR(0)="SA"_U_"C:Condensed;F:Full"
 S DIR("A")="Condensed or full inquiry? "
 S DIR("B")="C"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q "F"
 Q Y
 ;
 ;==========================================
MHDR(RM,MIEN,NL,OUTPUT) ;Produce the measure header text.
 N IENSTR,NIN,NOUT,NPAD,TEMP,TEXT,TEXTIN,TEXTOUT
 S IENSTR="No. "_IEN
 S TEMP=$$REPEAT^XLFSTR("-",RM)
 S OUTPUT(1)=TEMP
 S TEXT=$P(^PXRM(802.3,IEN,0),U,1)
 D FORMATS^PXRMTEXT(1,70,TEXT,.NOUT,.TEXTOUT)
 S NPAD=RM-$L(TEXTOUT(1))-1
 S OUTPUT(2)=TEXTOUT(1)_$$RJ^XLFSTR(IENSTR,NPAD," ")
 S NL=2
 I NOUT>1 F IND=2:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 S NL=NL+1,OUTPUT(NL)=TEMP
 S TEMP=^PXRM(802.3,MIEN,1)
 S NL=NL+1,OUTPUT(NL)="  CMS ID: "_$P(TEMP,U,1)
 S NL=NL+1,OUTPUT(NL)="  Version number: "_$P(TEMP,U,2)
 S NL=NL+1,OUTPUT(NL)="  GUID: "_$P(TEMP,U,3)
 S NL=NL+1,OUTPUT(NL)="  NQF number: "_$P(TEMP,U,4)
 S NL=NL+1,OUTPUT(NL)=""
 K TEXTIN,TEXTOUT
 S NIN=$P(^PXRM(802.3,MIEN,2,0),U,3)
 S TEXTIN(1)="Description: "_^PXRM(802.3,MIEN,2,1,0)
 F IND=2:1:NIN S TEXTIN(IND)=^PXRM(802.3,MIEN,2,IND,0)
 D FORMAT^PXRMTEXT(2,78,NIN,.TEXTIN,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 Q
 ;
 ;==========================================
MLISTF(MIEN,NL,OUTPUT) ;Produce the full measure list.
 N IND,NIN,NOUT,STEWARD,NUM,TEMP,TEXTIN,TEXTOUT,VSIEN,VSNAME
 S TEXTIN="Steward: "_$G(^PXRM(802.3,MIEN,5))
 D FORMATS^PXRMTEXT(3,78,TEXTIN,.NOUT,.TEXTOUT)
 F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 K TEXTIN,TEXTOUT
 S TEMP=^PXRM(802.3,MIEN,3)
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)=" Category: "_$P(TEMP,U,1)
 S NL=NL+1,OUTPUT(NL)=" Identifier: "_$P(TEMP,U,2)
 S NL=NL+1,OUTPUT(NL)=" Status: "_$P(TEMP,U,3)
 S NL=NL+1,OUTPUT(NL)=" Type: "_$P(TEMP,U,4)
 S NL=NL+1,OUTPUT(NL)=" Measure Set: "_$P(TEMP,U,5)
 S NL=NL+1,OUTPUT(NL)=" Sheetname: "_$P(TEMP,U,6)
 Q
 ;
 ;==========================================
VSLIST(MIEN,NVS,VSLIST) ;Build a list of value sets used by a measure.
 N IND,VSIEN,VSNAME,VSOID,VSVDATE
 S (IND,NVS)=0
 F  S IND=+$O(^PXRM(802.3,MIEN,7,IND)) Q:IND=0  D
 . S NVS=NVS+1
 . S VSOID=$P(^PXRM(802.3,MIEN,7,IND,0),U,1)
 . S VSVDATE=$P(^PXRM(802.3,MIEN,7,IND,0),U,2)
 . S VSIEN=$O(^PXRM(802.2,"OID",VSOID,""))
 . S VSNAME=$P(^PXRM(802.2,VSIEN,0),U,1)
 . S VSLIST(NVS)=VSNAME_U_VSOID_U_VSVDATE
 Q
 ;
 ;==========================================
VSLISTC(MIEN,NL,OUTPUT) ;Produce the condensed value set list.
 N FMTSTR,IND,JND,NOUT,NVS,TEXTIN,TEXTOUT,VSLIST
 S FMTSTR="5R2^72L"
 D VSLIST(MIEN,.NVS,.VSLIST)
 F IND=1:1:NVS D
 . S TEXTIN=IND_".^"_$P(VSLIST(IND),U,1)
 . D COLFMT^PXRMTEXT(FMTSTR,TEXTIN," ",.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(JND)
 Q
 ;
 ;==========================================
VSLISTF(MIEN,NL,OUTPUT) ;Produce the full value set list.
 N FMTSTR,IND,JND,NVS,NOUT,TEXTIN,TEXTOUT,VSLIST
 S FMTSTR="5R2^72L"
 D VSLIST(MIEN,.NVS,.VSLIST)
 F IND=1:1:NVS D
 . S TEXTIN=IND_".^"_$P(VSLIST(IND),U,1)
 . D COLFMT^PXRMTEXT(FMTSTR,TEXTIN," ",.NOUT,.TEXTOUT)
 . F JND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(JND)
 . S NL=NL+1,OUTPUT(NL)="       OID: "_$P(VSLIST(IND),U,2)
 . S NL=NL+1,OUTPUT(NL)="       Version Date: "_$$FMTE^XLFDT($P(VSLIST(IND),U,3))
 Q
 ;
