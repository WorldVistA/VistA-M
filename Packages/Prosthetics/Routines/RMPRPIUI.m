RMPRPIUI ;HINCIO/ODJ - CONVERT OLD PIP TO NEW PIP ;3/8/05  11:46
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 Q
 ;
 ;***** CONV - Convert Item records in 661.3 to 661.11
 ;             In the current PIP file design a HCPC Item is held as
 ;             free text in the form HCPCS-ITEM where HCPCS is the
 ;             HCPCS code (.01 field in 661.1 eg E0111) and ITEM is
 ;             the ien (ptr) to the item held on the ^RMPR(661.3,,3,)
 ;             multiple.
 ;             In the new design ITEM will be a number and not a pointer.
 ;             In this first pass through HCPCS Items the ITEM number
 ;             will be the same as ITEM ien for all commercial items.
 ;             Non-commercial items will have a different ITEM number
 ;             from their ITEM ien only where commercial and
 ;             non-commercial items have used the same HCPCS-ITEM code.
 ;             Non-commercial items will be ignored on this pass.
 ;             Any item whose Source field is not V
 ;             is assumed commercial.
 ;
CONV N RMPRHIEN,RMPRIIEN,RMPRHREC,RMPRIREC,RMPRHCPC,RMPRHIT,RMPRGBL
 N RMPR1,RMPR2,RMPR3,RMPRL13,RMPRI13,RMPR11,RMPRERR
 I '$D(IO("Q")) D
 . W !,"Creating HCPCS Items in file 661.11 - 1st pass "
 . Q
 ;
 ; Loop on HCPCS and Items as defined in the PSAS HCPCS file 661.1
 S RMPRHIEN=0
HCPC S RMPRHIEN=$O(^RMPR(661.1,RMPRHIEN))
 I '+RMPRHIEN G CONVX ;no more HCPCS so exit
 I '$D(IO("Q")) D
 . W:$X=79 ! W "."
 . Q
 S RMPRHREC=$G(^RMPR(661.1,RMPRHIEN,0)) ;HCPCS node
 S RMPRIIEN=0
ITEM S RMPRIIEN=$O(^RMPR(661.1,RMPRHIEN,3,RMPRIIEN))
 I '+RMPRIIEN G HCPC
 S RMPRIREC=$G(^RMPR(661.1,RMPRHIEN,3,RMPRIIEN,0)) ;HCPCS Item node
 S RMPRHCPC=$P(RMPRHREC,"^",1)
 I RMPRHCPC="" G ITEM
 S RMPRHIT=RMPRHCPC_"-"_RMPRIIEN
 ;
 ; create 661.11 rec if item in 661.3 (should be)
 S RMPRGBL="^RMPR(661.3,""D"","""_RMPRHIT_""")"
LOCI S RMPRGBL=$Q(@RMPRGBL)
 I $QS(RMPRGBL,1)'=661.3 G ITEM
 I $QS(RMPRGBL,2)'="D" G ITEM
 I $QS(RMPRGBL,3)'=RMPRHIT G ITEM
 S RMPR1=$QS(RMPRGBL,4) G:RMPR1="" LOCI
 S RMPR2=$QS(RMPRGBL,5) G:RMPR2="" LOCI
 S RMPR3=$QS(RMPRGBL,6) G:RMPR3="" LOCI
 S RMPRL13=$G(^RMPR(661.3,RMPR1,0))
 S RMPRI13=$G(^RMPR(661.3,RMPR1,1,RMPR2,1,RMPR3,0))
 ;
 ; create 661.11 record
 K RMPR11
 S RMPR11("STATION")=$P(RMPRL13,"^",3) ;Station must be in DIC(4
 I RMPR11("STATION")="" G LOCI
 I '$D(^DIC(4,RMPR11("STATION"))) G LOCI
 I $P(RMPRI13,"^",9)="V" G LOCI ;ignore non-commercial items on this pass
 S RMPR11("SOURCE")="C"
 S RMPR11("HCPCS")=RMPRHCPC
 S RMPR11("ITEM")=RMPRIIEN
 I $D(^RMPR(661.11,"ASHI",RMPR11("STATION"),RMPR11("HCPCS"),RMPR11("ITEM"))) G LOCI ;already defined
 S RMPR11("UNIT")=$P(RMPRI13,"^",4)
 S RMPR11("DESCRIPTION")=$P(RMPRIREC,"^",1)
 S RMPR11("ITEM MASTER IEN")=""
 S RMPRERR=$$CRE^RMPRPIX1(.RMPR11)
 G LOCI
 ;
 ;exit
CONVX Q
