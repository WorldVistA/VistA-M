ONCRESTG ;Hines OIFO/GWB - Restage 2003+ cases ;07/10/09
 ;;2.11;ONCOLOGY;**50**;Mar 07, 1995;Build 29
 ;
 ;Check T version
 ;S VER=$T(LOGO+3^ONCODIS)
 ;S VER=$E(VER,29)
 ;I VER>1 K VER Q
 ;
 N D0,RESTAGE,XDT
 S RESTAGE="YES"
 W !!," Restaging 2003+ cases"
 S XDT=3030000 F CNT=1:1 S XDT=$O(^ONCO(165.5,"ADX",XDT)) Q:XDT=""  S D0=0 F  S D0=$O(^ONCO(165.5,"ADX",XDT,D0)) Q:D0=""  D RESTAGE W:CNT#100=0 "."
 Q
 ;
RESTAGE ;Restage 6th Edition cases
 S STGIND="P"
 S (ONCED,ONCOED)=6
 S DA=D0
 S XX=$G(^ONCO(165.5,D0,2))
 Q:XX=""
 S ST=$P(^ONCO(165.5,D0,0),U,1)
 S G=$P(^ONCO(165.5,D0,2),U,5)
 S TX=$P(^ONCO(165.5,D0,2),U,1)
 S HT=$$HIST^ONCFUNC(D0)
 S SP=$P($G(^ONCO(164,+TX,0)),U,11)
 S XXX=$G(^ONCO(165.5,D0,2.1))
 S T=$P(XXX,U,1)
 S N=$P(XXX,U,2)
 S M=$P(XXX,U,3)
 S CM=$P($G(^ONCO(165.5,D0,2)),U,27)
 Q:M=CM
 I (T'="X")!(N'="X"),$E(M,1)'=1 S M=$S(CM="X":M,1:CM)
 E  Q
 Q:(T="")!(N="")!(M="")
 I T=88,N=88,M=88 Q
 ;
 ;Melanoma of the Eyelid (C44.1)
 I TX=67441,ONCED<5,$$MELANOMA^ONCOU55(D0) S AG=37 G AG
 ;
 ;Melanoma of the Skin
 I $$MELANOMA^ONCOU55(D0),$P($G(^ONCO(164,+TX,0)),U,15) S AG=22 G AG
 ;
 ;GTT
 I TX=67589 S AG=54 G AG
 ;
 ;Urethra (C68.9)
 ;Urothelial (Transitional Cell) Carcinoma of the Prostate
 I ONCED>4,TX=67619,(HT=81203)!(HT=81303)!(HT=81223)!(HT=81202) D  G AG
 .S AG=35
 ;
 ;Melanoma of the Conjunctiva
 I $$MELANOMA^ONCOU55(D0),TX=67690 S AG=39 G AG
 ;
 ;Melanoma of the Uvea
 I $$MELANOMA^ONCOU55(D0),((TX=67693)!(TX=67694)) S AG=40 G AG
 ;
 ;Lymphoid Neoplasms
 ;Mycosis fungoides (9700/3)
 ;Sezary Disease    (9701/3)
 I ONCED>5,(HT=97003)!(HT=97013) S AG=55 G AG
 ;
 S AG=$P($G(^ONCO(164,+TX,0)),U,12)
 ;
AG ;DO staging subroutine
 S SG=99
 I T=88,N=88,M=88 S SG=88 G SG
 D @(AG_"^ONCOTN0")
 ;
SG ;Computed stage
 S $P(^ONCO(165.5,D0,2.1),U,4)=SG
 I SG'="" S X=SG D KSG^ONCOCRC,PSSG^ONCOCRC
CHKSUM ;Recompute checksum
 I $P($G(^ONCO(165.5,D0,7)),U,2)=3 D
 .S EDITS="NO" D NAACCR^ONCGENED K EDITS
 .S CHECKSUM=$$CRC32^ONCSNACR(.ONCDST)
 .I CHECKSUM'=$P($G(^ONCO(165.5,D0,"EDITS")),U,1) D
 ..S $P(^ONCO(165.5,D0,"EDITS"),U,1)=CHECKSUM
 Q
