ENEQHS ;(WIRMFO)/JED/DH-POST REPAIR TO EQUIPMENT HISTORY ;5/11/2000
 ;;7.0;ENGINEERING;**35,42,48,59,65**;Aug 17, 1993
W ;W.O. HISTORY-ENTRY FROM COMP1^ENWOCOMP
 ;  EXPECTING W.O. VARIABLES U,DA,ENTEC & ENINV
 ;    where DA => IEN of work order file
 ;          ENINV => IEN of equipment file
 Q:$D(DIU(0))
 N ENACTN,ENDTCP,ENEMPL,ENWO,ENH,ENHRS,ENLABOR,ENMTL
 N ENODE,ENVEND,ENSTAT,ENWORK,ENWOX,I,J,J1,K
 I $D(^ENG(6920,DA,4)),$P(^(4),U,3)=5 Q
 I '$D(^ENG(6914,ENINV,0)) G EXIT ; equipment record not found
 S ENEMPL="" I ENTEC="" S ENEMPL=$S($E($P(^ENG(6920,DA,0),U),1,3)="PM-":"STAFF",1:"NO ENTRY") G W1
 I $D(^ENG("EMP",ENTEC,0)) S ENEMPL=$E($P(^(0),U),1,15)
W1 S ENWO=$P(^ENG(6920,DA,0),U) F K=0:0 S K=$O(^ENG(6914,ENINV,6,K)) Q:K'>0  S ENWOX=$P(^ENG(6914,ENINV,6,K,0),U,2) G:ENWOX=ENWO EXIT
 I '$D(^ENG(6920,DA,5)) S ENERR="NODE 5 OF W.O. IR #"_DA_" IS GONE!" G ERR
 S ENODE=^ENG(6920,DA,5)
 S ENDTCP=$P($P(ENODE,U,2),"."),ENHRS=$P(ENODE,U,3),ENMTL=$P(ENODE,U,4),ENLABOR=$P(ENODE,U,6),ENSTAT=$P(ENODE,U,8),ENWORK=$P(ENODE,U,7)
 S ENACTN="XX"
 I $D(^ENG(6920,DA,8)) D
 . F I=0:0 S I=$O(^ENG(6920,DA,8,I)) Q:I'>0!($L(ENACTN)=8)  D
 .. S J=$P(^ENG(6920,DA,8,I,0),U)
 .. Q:'$D(^ENG(6920.1,J,0))  S J1=$P(^(0),U,2)
 .. I ENACTN="XX" S ENACTN=""
 .. S ENACTN=ENACTN_J1
 S ENVEND="" I $D(^ENG(6920,DA,4)) S ENVEND=$P(^(4),U,4) I ENVEND]"" S ENVEND=$P(ENVEND,".",1)
 S ENH=ENDTCP_"-"_ENACTN_U_ENWO_U_ENSTAT_U_ENHRS_U_ENLABOR_U_ENMTL_U_ENVEND_U_ENEMPL_U_ENWORK
EXT ; post history info (ENH) to equipment (ENINV)
 Q:'$D(^ENG(6914,ENINV,0))
 N ENNXL,ENNXT,ENOUT,ENRN,ENW
 I $D(^ENG(6914,ENINV,6,0))'>0 S ^(0)="^6914.02A^0^0"
 S ENW=$P(^ENG(6914,ENINV,6,0),U,1,2),ENNXL=$P(^(0),U,3),ENNXT=$P(^(0),U,4)
 ;FOR REVERSE CHRONO, SUBTRACT YYYMMDD, X10 (TO HANDLE SAME DAY WO'S)
 S ENRN=(9999999-ENDTCP)*10
W2 I $D(^ENG(6914,ENINV,6,ENRN,0))>0 S ENRN=ENRN-1 G W2
 S:ENNXL<ENRN ENNXL=ENRN S ENNXT=ENNXT+1,ENOUT=ENW_U_ENNXL_U_ENNXT
 L +^ENG(6914,ENINV,6) S ^ENG(6914,ENINV,6,0)=ENOUT,^ENG(6914,ENINV,6,ENRN,0)=ENH L -^ENG(6914,ENINV,6)
EXIT ;
 Q
 ;
ERR W !!,*7,"ABORTING ATTEMPT TO POST INVENTORY WORK HISTORY",!,ENERR G EXIT
 ;
KILLHS ;REMOVE EXISTING HISTORY IF WO IS EDITED; CALLED BY ENWO1,ENWOD,ENWOME
 I $E($P(^ENG(6920,DA,0),U,1),1,3)="PM-" S R="" D PMTXT Q:R="^"
 W !!,*7,"WARNING: you must re-enter the DATE COMPLETE field,",!,"to re-post the device history ... DO THIS LAST!",!!,"<cr> to continue" R R:DTIME
 S ENWO=$P(^ENG(6920,DA,0),"^",1),ENINV=$P(^(3),"^",8) Q:'$D(^ENG(6914,ENINV,6,0))
 I ENINV'="" S ENZ=0 F I=1:1 S ENZ=$O(^ENG(6914,ENINV,6,ENZ)) Q:'ENZ  I $D(^ENG(6914,ENINV,6,ENZ,0)),$P(^(0),"^",2)=ENWO K ^ENG(6914,ENINV,6,ENZ,0) S $P(^ENG(6914,ENINV,6,0),"^",4)=$P(^ENG(6914,ENINV,6,0),"^",4)-1 Q
 K ENZ
 Q
 ;
PMTXT W !!,"Caution: DELETION of a PM work order at this point will remove the PM",!,"  from the Equipment History. The DELETE WORK ORDER option in the PM module",!,"  does not have this effect."
 R !!,"<cr> to continue, '^' to abort, '?' for help ",R:DTIME Q:R'="?"
 W !!,"If you intend to delete this work order AND remove its corresponding entry",!,"in the Equipment History, this is the way to do it."
 W !!,"If you simply want to edit the work order, this is the way to do that too."
 W !!,"If, however, you wish to delete the work order without removing the PM itself",!,"from the Equipment History, then you should enter caret keys ('^') to abort"
 W !,"and jump to DELETE PM WORK ORDER." G PMTXT
 ;
DELHS ;DELETE W.O. FROM EQUIPMENT HISTORY (non-interactive)
 ; Called by 'AD' MUMPS x-ref on STATUS field in WORK ORDER file for
 ;   disapproved work orders
 ; input
 ;   DA = ien of work order
 Q:'$G(DA)
 N END,ENINV,ENWO,ENZ
 S ENINV=$P($G(^ENG(6920,DA,3)),U,8)
 Q:'ENINV  ; no equipment pointer
 S ENWO=$P($G(^ENG(6920,DA,0)),U)
 ; loop thru equipment history to find and delete w.o. ENWO
 S (END,ENZ)=0 F  S ENZ=$O(^ENG(6914,ENINV,6,ENZ)) Q:'ENZ  D  Q:END
 . Q:$P($G(^ENG(6914,ENINV,6,ENZ,0)),U,2)'=ENWO  ; different w.o. #
 . ; found work order to be deleted
 . K ^ENG(6914,ENINV,6,ENZ,0)
 . S $P(^ENG(6914,ENINV,6,0),U,4)=$P(^ENG(6914,ENINV,6,0),U,4)-1
 . S END=1 ; stop loop
 Q
 ;ENEQHS
