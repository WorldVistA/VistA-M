MAGGTUX2 ;WIOFO/GEK Imaging utility to validate INDEX values.
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
INIT ; If this is a continuation, initialize the variables.
 ;W !,"MAGN ",MAGN
 I $P(^MAG(2005,0),"^",3)>$P(^XTMP(MAGN,0),"^",4) D
 . W !,"There are new images since this utility was last run."
 S IEN=$P($G(^XTMP(MAGN,0)),"^",3)+1 I IEN=1 D  Q  ; Already run, so start over.
 . S IEN="A"
 . W !!,"All Images were checked as of "_$$FMTE^XLFDT($P(^XTMP(MAGN,0),"^",2))
 . W !
 . W !,"For a summary of the last Check or Fix process use the menu option: "
 . W !,"     ""REV    Review a Summary of the last Fix or Check process."""
 . W !,"  or continue to Re-Check the Image file."
 W !,"Continue: where you left off, at IEN : ",IEN,"   Y/N   //N  :" R X:30
 I "Nn"[$E(X) W !,"Starting over..." S IEN="A" Q
 W !,"Continuing from IEN: ",IEN,!
 S NT=$G(^XTMP(MAGN,"AANT"))
 S NI=$G(^XTMP(MAGN,"AANI"))
 S GRINT=$G(^XTMP(MAGN,"AAGRINT"))
 S GRINI=$G(^XTMP(MAGN,"AAGRINI"))
 S GO1=$G(^XTMP(MAGN,"AAGO1"))
 S OFX=$G(^XTMP(MAGN,"AAOFX"))
 S INVG=$G(^XTMP(MAGN,"AAINVG"))
 S INVO=$G(^XTMP(MAGN,"AAINVO"))
 S NOMERG=$G(^XTMP(MAGN,"AANOMERG"))
 S OKMERG=$G(^XTMP(MAGN,"AAOKMERG"))
 S FIX=$G(^XTMP(MAGN,"AAFIX"))
 S CRCT=$G(^XTMP(MAGN,"AACRCT"))
 Q
TRK2 ; Keep a Count of Short Desc, transpose to compact the list.
 S SD=$P(N2,"^",4)
 S SD=$TR(SD,"0123456789+-/\.,~`!@#$%^&*()_-={}[]|:;""'<>?","")
 S SD=$TR(SD,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 F  Q:SD'["  "  S SD=$P(SD,"  ",1)_" "_$P(SD,"  ",2,999)
 S SD=$$TRIM^XLFSTR(SD,"LR")
 S:SD="" SD="[NO SHORT DESC]"
 S ^XTMP(MAGN,"MAIDSD",+IXT,+IXS,+IXP,"SD",SD)=$G(^XTMP(MAGN,"MAIDSD",+IXT,+IXS,+IXP,"SD",SD))+1
 Q
CHKCR(N40,IEN) ; Image has Procedure/Event CR, see if it should be CT.
 N INDXD
 D GENIEN^MAGXCVI(IEN,.INDXD)
 I $P(INDXD,"^",4)'=RADCT Q
 S CRCT=CRCT+1
 I COMMIT D
 . S FIX=FIX+1
 . S $P(^MAG(2005,IEN,40),"^",4)=RADCT
 . D ENTRY^MAGLOG("INDEX-CR",DUZ,IEN,"TUX59",MDFN,1)
 . Q
 Q
CHK45(N40,IEN) ;  Check the Origin Set of Codes.
 ; N40 passed by Ref, it may be changed in here.
 N ORG,NORG
 S ORG=$P(N40,"^",6)
 I "VNFD"[ORG Q  ; Valid
 ; get it's first Char.
 S $P(N40,"^",6)=$S("VNFD"[$E(ORG):$E(ORG),1:"")
 S OFX=OFX+1
 I COMMIT D
 . S FIX=FIX+1
 . S ^MAG(2005,IEN,40)=N40
 . D ENTRY^MAGLOG("INDEX-45",DUZ,IEN,"TUX59",MDFN,1)
 . Q
 Q
VALIND ;Validate the interdependency between Type, Spec, Proc/Event for Entries that have a TYpe.
 K MRY I $$VALTUX2^MAGGTUX3(.MRY,IXT,IXS,IXP) Q  ; Valid Type <-> Spec <-> Proc
 ; Keep list of Generated or User entered invalid Type<->Spec<->Proc
 I $D(^MAGIXCVT(2006.96,IEN)) S ^XTMP(MAGN,"MAIDXG",+IXT,+IXS,+IXP)=$G(^XTMP(MAGN,"MAIDXG",+IXT,+IXS,+IXP))+1,INVG=INVG+1
 E  S ^XTMP(MAGN,"MAIDXO",+IXT,+IXS,+IXP)=$G(^XTMP(MAGN,"MAIDXO",+IXT,+IXS,+IXP))+1,INVO=INVO+1
 D TRK2
 Q
VALMERG(O40,N40) ; N40 Passed by Ref.
 ; if the merged Proc-Spec in New 40 Node (N40) are not valid,
 ; Then just take the TYPE, and revert back to old O40 Spec and Proc
 K MRY
 I $$VALTUX2^MAGGTUX3(.MRY,$P(N40,"^",3),$P(N40,"^",5),$P(N40,"^",4)) S OKMERG=OKMERG+1 Q  ; Merged values are valid
 S NOMERG=NOMERG+1
 S $P(N40,"^",4,5)=$P(O40,"^",4,5) ; Put the Spec and Proc back to original way.
 Q
