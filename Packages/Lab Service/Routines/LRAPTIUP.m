LRAPTIUP ;DALOI/STAFF - API Print AP Reports from TIU ;11/05/10  17:30
 ;;5.2;LAB SERVICE;**259,315,350**;Sep 27, 1994;Build 230
 ;
 ; This API is used to extract Anatomic Pathology reports that have
 ; been stored in TIU and print them.
 ;
 ; Reference to TGET^TIUSRVR1 supported by IA #2944
 ; Reference to EXTRACT^TIULQ supported by IA #2693
 ;
MAIN(LRTIUDA,LRDEV) ; Control Branching
 ;
 ; LRTIUDA - IEN of document from TIU DOCUMENT (#8925) file
 ; LRDEV - 1 indicates use device handling in this routine
 ;         0 indicates use device handling of calling application
 ;
 N LRCNT,LRCNTT,LRCNTF,LRFLG,LRHFLG,LROR,LRPTR,LRTXT,LRVAL
 ;
 K ^TMP("LRTIU",$J),^TMP("LRTIUTXT",$J)
 ;
 S LRDEV=+$G(LRDEV)
 S LRPTR=LRTIUDA ; Used below in checking the checksum on document.
 S LRQUIT=0
 I '$G(LRTIUDA) D  Q
 . W $C(7),!,"The IEN from the TIU DOCUMENT (#8925) file is undefined.",!
 D EXTRACT
 I LRQUIT D END Q
 D DISSECT
 I LRQUIT D END Q
 D:LRDEV ASKDEV
 I $G(POP)!LRQUIT D END Q
 D REPORT
 D END
 Q
 ;
 ;
EXTRACT ; Extract the report from TIU
 D EXTRACT^TIULQ(LRTIUDA,"^TMP(""LRTIU"",$J)",,,,1,,1)
 I '+$P($G(^TMP("LRTIU",$J,LRTIUDA,"TEXT",0)),"^",3) D  Q
 . W $C(7),!!,"Document not found.",!
 . S LRQUIT=1
 M ^TMP("LRTIUTXT",$J)=^TMP("LRTIU",$J,LRTIUDA,"TEXT")
 Q
 ;
 ;
DISSECT ; Dissect the report into header, body, and footer
 S (LROR,LRCNT,LRCNTT,LRHFLG)=0,LRFLG="H"
 F  S LROR=$O(^TMP("LRTIUTXT",$J,LROR)) Q:LROR'>0!(LRQUIT)  D
 . S LRTXT=$G(^TMP("LRTIUTXT",$J,LROR,0))
 . I 'LRHFLG,LRTXT'="$APHDR" D  Q
 . . W $C(7),!!,"Document is not an Anatomic Pathology report.",!
 . . S LRQUIT=1
 . I LRTXT="$APHDR" D  Q
 . . S LRHFLG=1
 . . K ^TMP("LRTIUTXT",$J,LROR)
 . I LRFLG="H" D  Q:LRFLG="T"
 . . I LRTXT="$TEXT" D  Q
 . . . S ^TMP("LRTIUTXT",$J,"HDR")=LRCNT,LRCNT=0
 . . . K ^TMP("LRTIUTXT",$J,LROR)
 . . . S LRFLG="T",LRCNT=0
 . . Q:LRFLG="T"
 . . S LRCNT=LRCNT+1,LRCNTT=LRCNTT+1
 . . S ^TMP("LRTIUTXT",$J,"HDR",LRCNT)=LRTXT
 . . K ^TMP("LRTIUTXT",$J,LROR)
 . I LRFLG="T" D  Q:LRFLG="F"
 . . I LRTXT="$FTR" D  Q:LRFLG="F"
 . . . S ^TMP("LRTIUTXT",$J,"TEXT")=LRCNT,LRCNT=0
 . . . K ^TMP("LRTIUTXT",$J,LROR)
 . . . S LRFLG="F"
 . . Q:LRFLG="F"
 . . S LRCNT=LRCNT+1,LRCNTT=LRCNTT+1
 . . S ^TMP("LRTIUTXT",$J,"TEXT",LRCNT)=LRTXT
 . . K ^TMP("LRTIUTXT",$J,LROR)
 . I LRFLG="F" D
 . . S LRCNT=LRCNT+1,LRCNTT=LRCNTT+1
 . . S ^TMP("LRTIUTXT",$J,"FTR",LRCNT)=LRTXT
 . . K ^TMP("LRTIUTXT",$J,LROR)
 S ^TMP("LRTIUTXT",$J,"FTR")=LRCNT
 S ^TMP("LRTIUTXT",$J,0)=LRCNTT
 Q
 ;
 ;
ASKDEV ;
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! S LRQUIT=1 Q
 I $D(IO("Q")) D
 .S ZTDESC="Print Anat Path Reports"
 .S ZTRTN="REPORT^LRAPTIUP"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
 .S LRQUIT=1
 Q
 ;
 ;
REPORT ;
 U IO
 W:IOST?1"C-".E @IOF
 N LRPG,LRHDC,LRFTC,LRTXC,LRTOTPGS,LROR1,LROR2,LREND
 S (LRQUIT,LRPG,LREND)=0
 S LRHDC=+$G(^TMP("LRTIUTXT",$J,"HDR"))
 S LRFTC=+$G(^TMP("LRTIUTXT",$J,"FTR"))
 S LRTXC=+$G(^TMP("LRTIUTXT",$J,"TEXT"))
 ;
 I (IOSL-LRHDC-LRFTC-4)<1 S LRTOTPGS=LRTXC
 E  S LRTOTPGS=LRTXC\(IOSL-LRHDC-LRFTC-4) S:LRTXC#(IOSL-LRHDC-LRFTC-4) LRTOTPGS=LRTOTPGS+1
 ;
 D HEADER
 Q:LRQUIT
 ;
 ; Calculate LR and TIU checksums, if they don't match, set flag to scramble signature on the report.
 D CHKSUM
 I LRCKSUM'=0,LRCKSUM'=TIUCKSUM S LRENCRYP=1
 ;
 D BODY
 Q:LRQUIT
 S LREND=1
 D FOOTER
 Q
 ;
 ;
HEADER ;Report Header
 I LRPG>0,IOST?1"C-".E D  Q:LRQUIT
 . K DIR S DIR(0)="E"
 . D ^DIR W !
 . S:$D(DTOUT)!(X[U) LRQUIT=1
 W:LRPG>0 @IOF S LRPG=LRPG+1
 S LROR=0
 F  S LROR=$O(^TMP("LRTIUTXT",$J,"HDR",LROR)) Q:LROR'>0  D
 . S LRTXT=$G(^TMP("LRTIUTXT",$J,"HDR",LROR))
 . W LRTXT
 . I LRTXT["MEDICAL RECORD"!(LRTXT["AUTOPSY PROTOCOL"),$E(IOST,1,2)'="C-" W ?68,"Pg",$J(LRPG,3)," of ",LRTOTPGS
 . W !
 Q
 ;
 ;
BODY ; Body of Report
 S LROR1=0
 F  S LROR1=$O(^TMP("LRTIUTXT",$J,"TEXT",LROR1)) Q:LROR1'>0!(LRQUIT)  D
 . I $Y>(IOSL-LRFTC-5),$E(IOST,1,2)'="C-" D FOOTER,HEADER Q:LRQUIT
 . S LRTXT=$G(^TMP("LRTIUTXT",$J,"TEXT",LROR1))
 . I LRTXT["/es/",+$G(LRENCRYP) S LRTXT=$$ENCRYP^XUSRB1(LRTXT)
 . W LRTXT,!
 Q
 ;
 ;
FOOTER ;Report Footer
 S (LROR2,LRCNTF)=0
 I IOSL'>66 F  Q:$Y>(IOSL-LRFTC-5)  W !
 F  S LROR2=$O(^TMP("LRTIUTXT",$J,"FTR",LROR2)) Q:LROR2'>0  D
 . S LRCNTF=LRCNTF+1
 . S LRTXT=$G(^TMP("LRTIUTXT",$J,"FTR",LROR2))
 . I LRCNTF=2 D  Q
 . . I LRTXT'=""&(LRTXT'["(End") W LRTXT,! Q
 . . I 'LREND W ?57,"(See next page)",! Q
 . . W ?57,"(End of report)",!
 . W LRTXT,!
 Q
 ;
 ;
CHKSUM ;Compare LR and TIU checksums
 ; Get original checksum value from file 63
 N LRTREC,LRROOT,LRFILE,LRIENS,LRFLD,LRREL
 S (LRENCRYP,LRTREC)=0
 I LRSS="AU" D
 . S LRTREC=$O(^LR(LRDFN,101,"C",LRPTR,LRTREC))
 . S LRIENS=LRDFN_","
 . S LRFILE=63.101
 I LRSS'="AU" D
 . S LRTREC=$O(^LR(LRDFN,LRSS,LRI,.05,"C",LRPTR,LRTREC))
 . S LRIENS=LRI_","_LRDFN_","
 . S LRFILE=$S(LRSS="SP":63.19,LRSS="CY":63.47,LRSS="EM":63.49,1:"")
 I LRFILE=""!(LRTREC=0) S LRCKSUM=0 Q
 ; Retrieve LR checksum
 S LRIENS=LRTREC_","_LRIENS
 S LRCKSUM=$$GET1^DIQ(LRFILE,LRIENS,2)
 I LRCKSUM="" S LRCKSUM=0
 ;CKA-Calculate checksum of TIU report
 S $P(^TMP("LRTIU",$J,LRTIUDA,"TEXT",0),U,5)=$P(^TMP("LRTIU",$J,LRTIUDA,1201,"I"),".")
 S LRVAL="^TMP(""LRTIU"","_$J_","_LRTIUDA_",""TEXT"")"
 S TIUCKSUM=$$CHKSUM^XUSESIG1(LRVAL)
 Q
 ;
 ;
END ;
 W:IOST?1"P-".E @IOF
 I LRDEV D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("LRTIU",$J),^TMP("LRTIUTXT",$J)
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 K %ZIS,LRCKSUM,LRENCRYP,LRPTR,POP,TIUCKSUM
 K ZTDESC,ZTQUEUED,ZTREQ,ZTRTN
 Q
