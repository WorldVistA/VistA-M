PXRMPTD2 ;SLC/PKR/PJH - Reminder Inquiry print template routines. ;03/07/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,18**;Feb 04, 2005;Build 152
 ;================================================
DATE(FIND0,PIECE,FLDNUM,TITLE,RJC,PAD,FILENUM,FLG) ;Standard DATE
 N DATE,X
 S DATE=$P($G(FIND0),U,PIECE)
 I DATE'="" D
 . S DATE=$$FMTE^XLFDT(DATE,"5Z"),X=$$RJ^XLFSTR(TITLE,RJC,PAD),X=X_" "_DATE
 . D ^DIWP
 Q
 ;
 ;================================================
ENTRYNAM(VPTR) ;Given the variable pointer return the entry name. The
 ;variable pointer list contains the information necessary to do the
 ;look up.
 N IEN,FILENUM,NAME,ROOT
 I VPTR="" Q ""
 S IEN=$P(VPTR,";",1),ROOT=$P(VPTR,";",2),FILENUM=$P(PXRMFVPL(ROOT),U,1)
 S NAME=$$GET1^DIQ(FILENUM,IEN,.01,"","","")
 Q NAME
 ;
 ;================================================
FREQ(FREQ) ;Format frequency.
 I FREQ=-1 Q "Cannot be determined"
 I +FREQ=0 Q FREQ_" - Not indicated"
 I FREQ="99Y" Q "99Y - Once"
 N UNIT
 S UNIT=$S(FREQ["H":" hour",FREQ["D":" day",FREQ["W":" week",FREQ["M":" month",FREQ["Y":" year",1:" ?")_$S(+FREQ>1:"s",1:"")
 Q +FREQ_UNIT
 ;
 ;================================================
FTYPE(VPTR,CNT) ;Return finding type.
 N FTYPE,ROOT
 I VPTR="" Q "UNDEFINED?"
 S ROOT=$P(VPTR,";",2)
 I '$D(PXRMFVPL) N PXRMFVPL D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 S FTYPE=$S(CNT=1:$P(PXRMFVPL(ROOT),U,4),1:$P(PXRMFVPL(ROOT),U,2))
 Q FTYPE
 ;
 ;================================================
GENFREQ(PXF0) ;Print age range frequency set for findings.
 N PXF,PXW,PXAMIN,PXAMAX
 S PXF=$P(PXF0,U,4)
 I PXF="" Q ""
 S PXAMIN=$P(PXF0,U,2),PXAMAX=$P(PXF0,U,3)
 S PXW=$$FREQ(PXF)
 S PXW=PXW_$$FMTAGE^PXRMAGE(PXAMIN,PXAMAX)
 Q PXW
 ;
 ;================================================
GENIEN(FINDING) ;Return internal entry number for findings.
 N F0,IEN,PREFIX,ROOT,VPTR
 S ROOT="^PXD(811.9,D0,20,FINDING,0)"
 S F0=@ROOT
 S VPTR=$P(F0,U,1)
 I VPTR="" Q "UNDEFINED"
 S IEN=$P(VPTR,";",1),ROOT=$P(VPTR,";",2)
 I '$D(PXRMFVPL) N PXRMFVPL D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 S VPTR=PXRMFVPL(ROOT)
 S PREFIX=$P(VPTR,U,4)
 Q " (FI("_+FINDING_")="_PREFIX_"("_IEN_"))"
 ;
