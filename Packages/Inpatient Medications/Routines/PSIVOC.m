PSIVOC ;BIR/MV - NEW ORDER CHECKS DRIVER ;6 Jun 07 / 3:37 PM
 ;;5.0; INPATIENT MEDICATIONS ;**181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PSSDSAPI is supported by DBIA #5425.
 ;
OC ;
 ;Setup input drug list in PSPDRG array for IV order check (DD, DT). DRG array is expected
 NEW FIL,PSIVIEN,PSIVNM,PSIVAS,PSIVX,PSJCNT,PSJDD,PSJDSE,PSJO,PSJORIEN,PSPDRG,TMPDRG1,PSJALLGY
 ;If OC already done when FN action was used to finish pending IV, the K PSJOCCHK to ensure OC is not trigger again when edit on non * field
 K PSGORQF,PSIVEDIT,PSJALLGY,PSJOCCHK
 ;The variable PSIVEDIT is set in ^PSJLIFN.  If the finishing IV order without editing, the OC will get 
 ;triggered. Otherwise ^PSIVEDT will set off the OC.
 ;
 ;^PSOBUILD kills the DRG array.  The SAVEDRG will store DRG in temp and restore it as it's done /w OC.
 D SAVEDRG^PSIVEDRG(.TMPDRG1,.DRG) ;Store DRG array in TMPDRG array
 K ^TMP($J,"PSJPRE")
 D SETDD()
 ;Reset PSPDRG(n)=DD ien ^ Add/Sol name _ Unit
 D NMUNIT
 ;Perform enhance OC
 I $O(PSPDRG(0)) D OC^PSJOC(.PSPDRG,"I;"_$G(ON55))
 I '$O(PSPDRG(0)) D GMRAOC^PSJOC
 D SAVEDRG^PSIVEDRG(.DRG,.TMPDRG1) ;Restore DRG array from TMPDRG array
 I $G(PSGORQF) S X=U,DONE=1
 Q
DRGADD() ;Add the strength(no bottle only)/volume together for the same drug
 ;PSJFLG = Return 1 if it's the same drug
 I PSIVAS="SOL" Q 0
 NEW PSJFLG,PSJDD0,X,PSJSTVOL,PSJBOT1,PSJSVOL1,PSJSVOL2,PSJUNIT1,PSJUNIT2
 S PSJFLG=0
 F X=0:0 S X=$O(PSPDRG(X)) Q:'X  S PSJDD0=PSPDRG(X) D  Q:PSJFLG
 . I $P(PSJDD0,U,4)]"" Q
 . S PSJBOT1=$P(DRG(PSIVAS,PSIVX),U,4)
 . S PSJSVOL1=$P(DRG(PSIVAS,PSIVX),U,3)
 . S PSJSVOL2=$P(PSJDD0,U,3)
 . S PSJUNIT1=$P(PSJSVOL1," ",2)
 . S PSJUNIT2=$P(PSJSVOL2," ",2)
 . I (+PSJDD0=PSJDD),(PSJBOT1=""),(PSJUNIT1=PSJUNIT2) D
 .. S PSJSTVOL=(+PSJSVOL1)+(+PSJSVOL2)
 .. S $P(PSPDRG(X),U,3)=PSJSTVOL_" "_PSJUNIT1
 .. S PSJFLG=1
 Q PSJFLG
NMUNIT ;Combine name & unit to 2nd piece
 NEW PSJDD0,X
 F X=0:0 S X=$O(PSPDRG(X)) Q:'X  S PSJDD0=PSPDRG(X) D
 . S $P(PSJDD0,U,2)=$P(PSJDD0,U,2)_" "_$P(PSJDD0,U,3)
 . S $P(PSJDD0,U,3,4)=""
 . S PSPDRG(X)=PSJDD0
 Q
SETDD(PSJOCDS) ;
 ;PSJOCDS - Set to 1 if doing a dosing checks
 NEW PSJCNT,PSIVAS,FIL,PSIVX,PSIVIEN,PSJDUNIT
 K PSIVDDSV
 S PSJCNT=0
 F PSIVAS="AD","SOL" S FIL=$S(PSIVAS="AD":52.6,1:52.7) D
 . F PSIVX=0:0 S PSIVX=$O(DRG(PSIVAS,PSIVX)) Q:'PSIVX!($G(PSGORQF))  D
 .. S PSIVIEN=$P(DRG(PSIVAS,PSIVX),U)
 .. S PSJDD=$$IVDDRG^PSJMISC(PSIVAS,PSIVIEN)
 .. S PSJALLGY(PSJDD)=""
 .. S PSIVNM=$P(DRG(PSIVAS,PSIVX),U,2)_U_$P(DRG(PSIVAS,PSIVX),U,3)
 .. ;if it is not a premix, don't add to the prospective list
 .. I PSIVAS="SOL" D  Q:'$$PREMIX^PSJMISC(PSIVIEN)
 ... S PSIVDDSV("TOT_VOL")=$G(PSIVDDSV("TOT_VOL"))+$P(DRG(PSIVAS,PSIVX),U,3)
 .. ;If same drug then add the strength/volume together
 .. Q:$$DRGADD()
 .. D NONDS
 D:$G(PSJOCDS) DS
 Q
NONDS ;Set dispense drug list for DD, & DT (screen out supply items)
 ;PSPDRG(n) here has 4 pieces - DD ien ^ Add/Sol Name ^ Dose & Unit ^ bottle #
 I '$G(PSJOCDS),$$SUP^PSSDSAPI(PSJDD) Q
 I $G(PSJOCDS),$$EXMT^PSSDSAPI(PSJDD) Q
 S PSJCNT=PSJCNT+1
 S PSPDRG(PSJCNT)=PSJDD_U_PSIVNM_U_$P(DRG(PSIVAS,PSIVX),U,4)_$S($G(PSJOCDS):"^"_PSIVAS,1:"")
 Q
DS ;Set PSIVDDSV array for the dose check (screen out dose exempted items)
 ;PSIVDDSV= see def in ^PSIVOCDS
 NEW PSJX,PSJX0,PSJDOSE,PSJUNIT,PSJUNIT1
 F PSJX=0:0 S PSJX=$O(PSPDRG(PSJX)) Q:'PSJX  D
 . S PSJX0=$G(PSPDRG(PSJX))
 . S PSJDOSE=+$P(PSJX0,U,3)
 . S PSJUNIT1=$P($P(PSJX0,U,3)," ",2)
 . S PSJUNIT=$$UNIT^PSSDSAPI(PSJUNIT1)
 . S:$P(PSJX0,U,5)]"" PSIVDDSV($P(PSJX0,U,5),PSJX)=$P(PSJX0,U)_U_$P(PSJX0,U,2)_U_$P(PSJX0,U,3)_U_$P(PSJX0,U,4)_U_U_U_U_PSJDOSE_U_PSJUNIT
 Q
