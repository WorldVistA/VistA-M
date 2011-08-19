VBECDCX1 ;hoifo/gjc-data conversion & pre-implementation data extract;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
ANTIAB ;save off totals of ANTIBODIES IDENTIFIED, ANTIBODIES IDENTIFIED
 ;COMMENTS, RBC ANTIGENS PRESENT, RBC ANTIGENS PRESENT COMMENT,
 ;RBC ANTIGENS ABSENT, RBC ANTIGENS ABSENT COMMENT.
 ;total up the number of times antigens present/absent & antibodies
 ;identified appear in patient specific data
 I $P(LRD,U)'="" S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE)+1
 I $P(LRD,U,2)'="" D
 .S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE+1)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE+1)+1 ;do comments exist?
 .;save # of comment chars
 .S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE+2)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,LRPCE+2)+$L($$STRIP^VBECDCX1($P(LRD,U,2)))
 .Q
 Q
 ;
TRDTAB ;tabulate the number of transfusion date/time and transfusion reaction
 ;type records
 I $P(LRD,U)'="" S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,22)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,22)+1
 I $P(LRD,U,2)'="" S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,23)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,23)+1
 Q
 ;
TRCMNT ;tabulate the number of transfusion comments and the total number of
 ;characters for all transfusion comments.
 ;LRTRCMT defined in TCTRC^VBECDCX
 S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,25)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,25)+$L(LRTRCMT)
 Q
 ;
BBC(DFN,LRDFN) ; extract 'BLOOD BANK COMMENTS' data from the legacy
 ; Blood Bank application.  The first node will have the timestamp
 ; (date) of when the comments were most recently edited.
 ; Input: DFN=patient DFN
 ;      LRDFN=lab patient ien in the Lab Data (#63) file
 S (LRD1,Z)=0,LRBBCDT=$P($G(^LR(LRDFN,3,0)),U,5)
 S LRBBCDT=$P(LRBBCDT,".") ;RLM 03/27/2007
 S:LRBBCDT'?7N LRBBCDT=-1 ;should be a date w/o time
 S:LRBBCDT'=-1 LRBBCDT=$$DATE^VBECDCU(LRBBCDT)
 S:LRBBCDT=-1 LRBBCDT="" ;RLM 03/27/2007
 F  S LRD1=$O(^LR(LRDFN,3,LRD1)) Q:'LRD1  D
 .S LRD=$G(^LR(LRDFN,3,LRD1,0)) Q:LRD=""
 .;translate carets '^' to nulls
 .S LRD=$TR(LRD,"^","")
 .;strip leading spaces & trailing spaces
 .S LRD=$$STRIP(LRD),Z=Z+1
 .S LRSTR=LRDFN_U_DFN_U_LRD1_U_LRD_U_LRBBCDT
 .S:Z=1 $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,26)=1
 .S $P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,27)=$P(^TMP("VBEC FINIS",$J,VBECRTOT,0),U,27)+$L(LRD)
 .S CNT=$$CNT^VBECDCU("VBEC63 BBC",$J)
 .S CNT=CNT+1,^TMP("VBEC63 BBC",$J,CNT,0)=LRSTR_$C(13)
 .S VBECTOT("VBEC63 BBC")=+$G(VBECTOT("VBEC63 BBC"))+1
 .;total BBC character count for ALL records.
 .S $P(^TMP("VBEC FINIS",$J,0),U,27)=+$P(^TMP("VBEC FINIS",$J,0),U,27)+$L(LRD)
 .;total up the number of instances Blood Bank Comments (BBC)
 .S:Z=1 $P(^TMP("VBEC FINIS",$J,0),U,26)=+$P(^TMP("VBEC FINIS",$J,0),U,26)+1
 .Q
 K CNT,I,LRBBCDT,LRD,LRD1,LRSTR,Z
 Q
 ;
STRIP(X) ;strip leading and trailing spaces from a data string.
 ; input: string to be checked for leading and trailing spaces
 ;return: string without leading and trailing spaces
 ;strip leading spaces first...
 F  Q:$F(X," ")'=2  S X=$E(X,2,$L(X))
 ;then strip trailing spaces...
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
 ;
