XDRMERGC ;SF-CIOFO/JDS - CHECK MERGE ;06/02/99  09:10
 ;;7.3;TOOLKIT;**40**;Jun 1, 1999
 ;
 Q
CHKFROM(FROM,FILE) ;
 ;
 ; The following code is used to identify any pairs which have a same internal number in them and to
 ; exclude any after the first occurence of the internal number from the current merge
 ; the first occurrence is that based on the lowest ien for the FROM entry and the lowest ien for a
 ; TO entry associated with it.  Any other pairs involving either of these iens is then excluded.
 ;
 ; The XDRBROWSER1 device is used to capture any output generated due to exclusion of pairs and is
 ; then sent as a mail message.
 ;
 N FRA,TOA,FR,TO
 S IOP="XDRBROWSER1" D ^%ZIS
 U IO
 F FRA=0:0 S FRA=$O(@FROM@(FRA)) Q:FRA'>0  D
 . S TOA=$O(@FROM@(FRA,0))
 . F FR=FRA,TOA F TO=0:0 S TO=$O(@FROM@(FR,TO)) Q:TO=""  I FR'=FRA!(TO'=TOA) D EXCLUDE(FILE,FROM,FR,TO,FR,(TO=FRA))
 . F FR=0:0 S FR=$O(@FROM@(FR)) Q:FR'>0  D:$D(@FROM@(FR,FRA)) EXCLUDE(FILE,FROM,FR,FRA,FRA,1) I FR'=FRA D:$D(@FROM@(FR,TOA)) EXCLUDE(FILE,FROM,FR,TOA,TOA,0)
 D ^%ZISC K ^TMP("DDB",$J,1)
 I $D(^TMP("DDB",$J)) D SENDMESG^XDRDVAL1("PAIRS EXCLUDED FROM MERGE DUE TO MULTIPLE REFERENCES","^TMP(""DDB"",$J,")
 Q
 ;
EXCLUDE(FILE,FROM,FR,TO,WHICH,FROMREF) ;
 N VREF,VFR,VTO
 S VREF=""
 S VFR=$O(@FROM@(FR,TO,"")) I VFR="" S VFR=0,VREF=@FROM@(FR,TO)
 S VTO=$O(@FROM@(FR,TO,VFR,"")) S:VTO="" VTO=0
 I VTO>0 S VREF=@FROM@(FR,TO,VFR,VTO)
 D RMOVPAIR^XDRDVAL1(FR,TO,VREF,FROM)
 D PAIRID^XDRDVAL1(FILE,FR,TO,VREF)
 W !,"   Excluded as a multiple pair including ien=",WHICH,!
 I FROMREF>0,VREF>0 D RESET^XDRDPICK(VREF)
 Q
 ;
