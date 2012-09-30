PXRMCSTX ;SLC/PKR - Routines for taxonomy code set update. ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**9,12,17,18**;Feb 04, 2005;Build 152
 ;
 ;=====================================================
ADDTMSG(LC,MSG) ;Add a set of messages to the global message.
 N IND
 S IND=0
 F  S IND=$O(MSG(IND)) Q:IND=""  S LC=LC+1,^TMP("PXRMXMZ",$J,LC,0)=MSG(IND)
 Q
 ;
 ;=====================================================
ADJMSG(FILENUM,LOW,HIGH,ALOW,ALOWC,ALOWO,AHIGH,AHIGHC,AHIGHO,ADJMSG) ;
 ;Create the message for adjacent codes that have changed.
 N LC,TYPE
 K ADJMSG
 S TYPE=$S(FILENUM=80:"ICD9",FILENUM=80.1:"ICD0",FILENUM=81:"CPT")
 S ADJMSG(1)="Adjacent "_TYPE_" codes have changed for the range defined by:"
 S ADJMSG(2)=" Low code  "_$$GETCTEXT(FILENUM,LOW)
 S ADJMSG(3)=" High code "_$$GETCTEXT(FILENUM,HIGH)
 S LC=3
 I ALOWC D
 . S LC=LC+1,ADJMSG(LC)="  Old adjacent lower code "_$$GETCTEXT(FILENUM,ALOWO)
 . S LC=LC+1,ADJMSG(LC)="  New adjacent lower code "_$$GETCTEXT(FILENUM,ALOW)
 E  S LC=LC+1,ADJMSG(LC)="  No change in adjacent lower code"
 I AHIGHC D
 . S LC=LC+1,ADJMSG(LC)="  Old adjacent higher code "_$$GETCTEXT(FILENUM,AHIGHO)
 . S LC=LC+1,ADJMSG(LC)="  New adjacent higher code "_$$GETCTEXT(FILENUM,AHIGH)
 E  S LC=LC+1,ADJMSG(LC)="  No change in adjacent higher code"
 S LC=LC+1,ADJMSG(LC)=" "
 Q
 ;
 ;=====================================================
CMSGHDR(TYPE) ;Create the message header.
 N PTYPE
 S PTYPE=$S(TYPE="CPT":"a CPT",TYPE="ICD":"an ICD")
 S ^TMP("PXRMXMZ",$J,1,0)="There was "_PTYPE_" code set update on "_$$FMTE^XLFDT(DT,"5Z")_"."
 S ^TMP("PXRMXMZ",$J,2,0)="This could affect adjacent codes and/or taxonomy expansions."
 S ^TMP("PXRMXMZ",$J,3,0)="Please review the affected taxonomies and take appropriate action."
 S ^TMP("PXRMXMZ",$J,4,0)="You can get the full details of a taxonomy using the taxonomy inquiry option."
 S ^TMP("PXRMXMZ",$J,5,0)=" "
 Q
 ;
 ;=====================================================
CSU(TYPE) ;Entry point for code set update.
 I TYPE'="CPT",TYPE'="ICD" Q
 N ADJMSG,ALOW,ALOWC,ALOWO,AHIGH,AHIGHC,AHIGHO,CODEIEN,CODEMSG
 N FI,FILELIST,FILENUM,IEN,IND,HIGH,LC,LOW,NFILES,NNEW,NEWCODES,SENDMSG
 N TAXHDRE,TAXHDRL,TAXHDRS,TAXMSG,TEMP,XMSUB
 I TYPE="CPT" S NFILES=1,FILELIST(1)=81
 I TYPE="ICD" S NFILES=2,FILELIST(1)=80,FILELIST(2)=80.1
 K ^TMP("PXRMXMZ",$J)
 ;Set the line count to the end of the taxonomy header.
 S TAXHDRS=6,TAXHDRL=1,TAXHDRE=TAXHDRS+TAXHDRL,LC=TAXHDRE
 S (IEN,SENDMSG)=0
 F  S IEN=+$O(^PXD(811.2,IEN)) Q:IEN=0  D
 . F FI=1:1:NFILES D
 .. S FILENUM=FILELIST(FI)
 .. I '$D(^PXD(811.2,IEN,FILENUM,"B")) Q
 .. S (IND,TAXMSG)=0
 .. F  S IND=+$O(^PXD(811.2,IEN,FILENUM,IND)) Q:IND=0  D
 ... S TEMP=^PXD(811.2,IEN,FILENUM,IND,0)
 ... S LOW=$P(TEMP,U,1),HIGH=$P(TEMP,U,2)
 ... S ALOWO=$P(TEMP,U,3),AHIGHO=$P(TEMP,U,4)
 ... S ALOW=$S(FILENUM=80:$$PREV^ICDAPIU(LOW),FILENUM=80.1:$$PREV^ICDAPIU(LOW),FILENUM=81:$$PREV^ICPTAPIU(LOW))
 ... S AHIGH=$S(FILENUM=80:$$NEXT^ICDAPIU(HIGH),FILENUM=80.1:$$NEXT^ICDAPIU(HIGH),FILENUM=81:$$NEXT^ICPTAPIU(HIGH))
 ... I ALOW'=ALOWO S ALOWC=1,$P(^PXD(811.2,IEN,FILENUM,IND,0),U,3)=ALOW
 ... E  S ALOWC=0
 ... I AHIGH'=AHIGHO S AHIGHC=1,$P(^PXD(811.2,IEN,FILENUM,IND,0),U,4)=AHIGH
 ... E  S AHIGHC=0
 ... I (ALOWC)!(AHIGHC) D
 .... D ADJMSG(FILENUM,LOW,HIGH,ALOW,ALOWC,ALOWO,AHIGH,AHIGHC,AHIGHO,.ADJMSG)
 .... D ADDTMSG(.LC,.ADJMSG)
 .... S TAXMSG=1
 ..;Save the old expansion and compare with the new one.
 .. K ^TMP($J,"OLDEXP")
 .. S IND=0
 .. F  S IND=+$O(^PXD(811.3,IEN,FILENUM,IND)) Q:IND=0  D
 ... S CODEIEN=^PXD(811.3,IEN,FILENUM,IND,0)
 ... S ^TMP($J,"OLDEXP",CODEIEN)=""
 ..;Rexpand and compare with the old.
 .. D DELEXTL^PXRMBXTL(IEN)
 .. D EXPAND^PXRMBXTL(IEN,"")
 ..;Old codes are never deleted from the ICD or CPT globals so just
 ..;check for new entries in the expansion.
 .. S (IND,NNEW)=0
 .. F  S IND=+$O(^PXD(811.3,IEN,FILENUM,IND)) Q:IND=0  D
 ... S CODEIEN=^PXD(811.3,IEN,FILENUM,IND,0)
 ... I '$D(^TMP($J,"OLDEXP",CODEIEN)) S NNEW=NNEW+1,NEWCODES(NNEW)=CODEIEN
 ..;If there are any new codes add them to the message.
 .. I NNEW>0 D
 ... D NEWCMSG(FILENUM,NNEW,.NEWCODES,.CODEMSG)
 ... D ADDTMSG(.LC,.CODEMSG)
 ... S TAXMSG=1
 ..;Check the selectable codes.
 .. D SELCODE^PXRMCSSC(FILENUM,IEN,.LC,.TAXMSG)
 .. I TAXMSG D
 ... D TAXHDR(IEN,TAXHDRS)
 ... S TAXHDRS=LC+1,TAXHDRE=TAXHDRS+TAXHDRL,LC=TAXHDRE
 ... S SENDMSG=1
 S XMSUB="Clinical Reminder taxonomy updates, new "_TYPE_" global installation."
 I SENDMSG D CMSGHDR(TYPE)
 I 'SENDMSG D
 . S ^TMP("PXRMXMZ",$J,1,0)="No changes in adjacent high and low codes were found."
 . S ^TMP("PXRMXMZ",$J,2,0)="No inactive selectable codes were found."
 . S ^TMP("PXRMXMZ",$J,3,0)="No action is necessary."
 D SEND^PXRMMSG("PXRMXMZ",XMSUB,"",DUZ)
 K ^TMP("PXRMXMZ",$J),^TMP($J,"OLDEXP")
 Q
 ;
 ;=====================================================
GETCTEXT(FILENUM,CODE) ;Return the code and text associated with the code.
 N TEMP,TEXT
 I FILENUM=80 D  Q TEXT
 . S TEMP=$$ICDDX^ICDCODE(CODE,DT)
 . S TEXT=$P(TEMP,U,2)_"-"_$P(TEMP,U,4)
 I FILENUM=80.1 D  Q TEXT
 . S TEMP=$$ICDOP^ICDCODE(CODE,DT)
 . S TEXT=$P(TEMP,U,2)_"-"_$P(TEMP,U,5)
 I FILENUM=81 D
 . S TEMP=$$CPT^ICPTCOD(CODE,DT)
 . S TEXT=$P(TEMP,U,2)_"-"_$P(TEMP,U,3)
 Q TEXT
 ;
 ;=====================================================
NEWCMSG(FILENUM,NNEW,NEWCODES,CODEMSG) ;Create the message for new codes
 ;appearing in the expansion.
 I NNEW=0 Q
 N LC,IND,TYPE
 K CODEMSG
 S TYPE=$S(FILENUM=80:"ICD9",FILENUM=80.1:"ICD0",FILENUM=81:"CPT")
 S CODEMSG(1)="The following "_TYPE_" codes were not in the previous expansion for this taxonomy:"
 S LC=1
 F IND=1:1:NNEW D
 . S CODE=NEWCODES(IND)
 . S LC=LC+1,CODEMSG(LC)=" "_$$GETCTEXT(FILENUM,CODE)
 S LC=LC+1,CODEMSG(LC)=" "
 Q
 ;
 ;=====================================================
TAXHDR(IEN,LC) ;Create message header for a specific taxonomy.
 S ^TMP("PXRMXMZ",$J,LC,0)="Taxonomy: "_$P(^PXD(811.2,IEN,0),U,1)_" = TX("_IEN_")"
 Q
 ;
