GMTSPN1 ; SLC/KER - Progress Note Header/Sig/Text/Prob ; 5/17/06 2:03pm
 ;;2.7;Health Summary;**12,35,45,49,81**;Oct 20, 1995;Build 23
 Q
 ;                          
 ; External References
 ;    DBIA 10104 call $$UP^XLFSTR
 ;                     
 ; Write Headers
WH ;   Note Header
 Q:$D(GMTSQIT)  I GMTSCNT>1 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 W $G(PN("DATE")),?18,"Local Title: ",$$UP^XLFSTR($G(PN("DOCTYPE"))),!
 I $D(PN("VHATYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?15,"Standard Title: ",PN("VHATYPE"),!
 S (ADATE,PDATE)=$G(PN("DATE")),(ATYPE,PTYPE)=$G(PN("DOCTYPE")),(ASUB,PSUB)=$G(PN("SUBJ"))
 I $D(PN("AUTH")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?20,PN("AUTH"),!
 I PN("SUBJ")'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?19,"Subject:  ",PN("SUBJ"),!
 Q
WDH ;   Discharge Summary Header
 Q:$D(GMTSQIT)  I GMTSCNT>1 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ADMIT,?12,"-",?14,DISCHG,?56,"Status: ",STATUS,!
 I $D(PN("DOCTYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?9,"Local Title: ",PN("VHATYPE"),!
 I $D(PN("VHATYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?6,"Standard Title: ",PN("VHATYPE"),!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?3,"Last Tr Specialty: ",TSPEC,?49,"Dict'd By: ",AUTHOR,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?47,"Approved By: ",ATTNDNG,!
 Q
WDBH ;   Brief Discharge Summary Header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Admitted",?11,"Disch'd",?23,"Dictated By",?38,"Approved By",?53,"Cosigned",?64,"Status",!! Q
WAH ;   Addendum Header
 Q:$D(GMTSQIT)  I GMTSCNT>1 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 W PN("DATE"),?18,"Local Title: ",$$UP^XLFSTR(PN("DOCTYPE")),!
 I $D(PN("VHATYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?15,"Standard Title: ",PN("VHATYPE"),!
 I $L($G(ADATE)),$L($G(ATYPE)) D  Q:$D(GMTSQIT)
 . I $D(GMTSREF) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,"Ref:  ",$E(ATYPE,1,25),?55,"Dated:  ",ADATE,!
 I $D(PN("AUTH")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?20,PN("AUTH"),!
 I PN("SUBJ")'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?19,"Subject:  ",PN("SUBJ"),!
 I '$L($G(PN("SUBJ"))),$L($G(ASUB)) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?19,"Subject:  ",$G(ASUB),!
 Q
ST(X) ;   Sub-Titles
 N GMTS,GMTS1,GMTS2,GMTST,GMTSB S GMTST=$G(X) Q:'$L(GMTST)
 S GMTST="<< "_GMTST_" >>",GMTS="",$P(GMTS,"-",((((79-$L(GMTST))\2)\2)-6))="-"
 S $P(GMTS1," ",((((79-$L(GMTST))\2)\2)+6))=" "
 S GMTS2=GMTS_GMTS1,GMTS1=GMTS1_GMTS,GMTSB=GMTS1_GMTST_GMTS2
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,GMTSB D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WIH ;   Interdisciplinary Note Header
 Q:$D(GMTSQIT)  I GMTSCNT>1 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 W PN("DATE"),?18,"Local Title: ",$$UP^XLFSTR(PN("DOCTYPE"))
 I $D(PN("VHATYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?15,"Standard Title: ",PN("VHATYPE"),!
 S ADATE=$G(PN("DATE")),ATYPE=$G(PN("DOCTYPE")),ASUB=$G(PN("SUBJ"))
 I $L($G(PDATE)),$L($G(PTYPE)) D  Q:$D(GMTSQIT)
 . I $D(GMTSREF) D CKP^GMTSUP Q:$D(GMTSQIT)  W !,?23,"Ref:  ",$E(PTYPE,1,25),?55,"Dated:  ",PDATE
 I $D(PN("AUTH")) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?20,PN("AUTH")
 I PN("SUBJ")'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W !?19,"Subject:  ",PN("SUBJ")
 I '$L($G(PN("SUBJ"))),$L($G(PSUB)) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?19,"Subject:  ",$G(PSUB)
 Q
WAIH ;   Addendum to Interdisciplinary Note Header
 Q:$D(GMTSQIT)  I GMTSCNT>1 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 W PN("DATE"),?18,"Local Title: ",$$UP^XLFSTR(PN("DOCTYPE"))
 I $D(PN("VHATYPE")) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?15,"Standard Title: ",PN("VHATYPE"),!
 I $L($G(ADATE)),$L($G(ATYPE)) D  Q:$D(GMTSQIT)
 . I $D(GMTSREF) D CKP^GMTSUP Q:$D(GMTSQIT)  W !,?23,"Ref:  ",$E(ATYPE,1,25),?55,"Dated:  ",ADATE
 I $L($G(PDATE)),$L($G(PTYPE)) D  Q:$D(GMTSQIT)
 . I $D(GMTSREF) D CKP^GMTSUP Q:$D(GMTSQIT)  W !,?23,"Ref:  ",$E(PTYPE,1,29),?55,"Dated:  ",PDATE
 I $D(PN("AUTH")) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?20,PN("AUTH")
 I PN("SUBJ")'="" D CKP^GMTSUP Q:$D(GMTSQIT)  W !?19,"Subject:  ",PN("SUBJ")
 I '$L($G(PN("SUBJ"))),$L($G(ASUB)) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?19,"Subject:  ",$G(ASUB)
 I '$L($G(PN("SUBJ"))),'$L($G(ASUB)),$L(PSUB) D CKP^GMTSUP Q:$D(GMTSQIT)  W !?19,"Subject:  ",$G(PSUB)
 Q
 ; Write Note
WT(X,I) ;   Write Progress Note Text
 N GMTSD,GMTSIEN S GMTSD=$G(X),GMTSIEN=$G(I) Q:'$L(GMTSIEN)  Q:$E($P(GMTSD,$J,1),1,11)'="^TMP(""TIU"","
 Q:'$D(@($P(GMTSD,",",1,($L(GMTSD,",")-1))_")"))  Q:'$D(@(GMTSD_GMTSIEN_")"))  S GMTSD=GMTSD_GMTSIEN_",""TEXT"","
 N GMTSK S GMTSK=0 F  S GMTSK=$O(@(GMTSD_GMTSK_")")) Q:+GMTSK'>0  D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !,$G(@(GMTSD_GMTSK_",0)"))
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WP(X,I) ;   Writes Problems associated with Note
 Q:$G(TIUNAM)["DISCHARGE"
 N GMTSD,GMTSIEN S GMTSD=$G(X),GMTSIEN=$G(I) Q:'$L(GMTSIEN)  Q:$E($P(GMTSD,$J,1),1,11)'="^TMP(""TIU"","
 Q:'$D(@($P(GMTSD,",",1,($L(GMTSD,",")-1))_")"))  Q:'$D(@(GMTSD_GMTSIEN_")"))  S GMTSD=GMTSD_GMTSIEN_",""PROBLEM"","
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,"PROBLEM(S):  "
 N GMTSPR S GMTSPR=0 F  S GMTSPR=$O(@(GMTSD_GMTSPR_")")) Q:+GMTSPR'>0  D  Q:$D(GMTSQIT)
 . D:GMTSPR>1 CKP^GMTSUP Q:$D(GMTSQIT)  W !?15,$G(@(GMTSD_GMTSPR_",0)"))
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
AM(X,I) ;   Write Amendment
 Q:$D(GMTSQIT)  N GMTSD,GMTSIEN,GMTSA,GMTSI S GMTSD=$G(X),GMTSIEN=$G(I) Q:'$L(GMTSIEN)  Q:$E($P(GMTSD,$J,1),1,11)'="^TMP(""TIU"","
 Q:'$D(@($P(GMTSD,",",1,($L(GMTSD,",")-1))_")"))  Q:'$D(@(GMTSD_GMTSIEN_")"))
 S GMTSD=GMTSD_GMTSIEN_"," D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !,$G(@(GMTSD_"1601,""E"")")),"  AMENDMENT FILED:"
 I $G(@(GMTSD_"1603,""E"")"))'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !?10 F GMTSI=1:1:$L($G(@(GMTSD_"1602,""E"")"))) W "_"
 I $G(@(GMTSD_"1604,""E"")"))'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !?28,"  /es/ ",$G(@(GMTSD_"1604,""E"")"))
 I $G(@(GMTSD_"1605,""E"")"))'="" D  Q:$D(GMTSQIT)
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W !?34,$G(@(GMTSD_"1605,""E"")"))
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 Q
WDB(X,I) ;   Writes Brief Discharge Summary
 Q:$D(GMTSQIT)  N GMTSD,GMTSIEN,GMTSA,GMTSI S GMTSD=$G(X),GMTSIEN=$G(I) Q:'$L(GMTSIEN)  Q:$E($P(GMTSD,$J,1),1,11)'="^TMP(""TIU"","
 Q:'$D(@($P(GMTSD,",",1,($L(GMTSD,",")-1))_")"))  Q:'$D(@(GMTSD_GMTSIEN_")"))
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG WDBH
 W $E($G(ADMIT),1,12),?11,$E($G(DISCHG),1,12),?23,$E($G(AUTHOR),1,14),?38,$E($G(ATTNDNG),1,14),?53,$E($G(COSIG),1,10),?64,$G(STATUS),!
 Q
