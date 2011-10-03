ENWOCOMP ;(WIRMFO)/DLM/JED/DH-TEST FOR COMPLETED WORK ORDER ;5/11/1998
 ;;7.0;ENGINEERING;**35,53**;Aug 17, 1993
 ;  Called by x-refs in File 6920 and by various engineering work
 ;    order routines.
 ;  Expects DA as IEN to File 6920.
 ;  Principal tasks are to maintain incomplete work order list and
 ;    to call for posting of equipment repair history.
TEST ;Is work order complete?
 Q:$D(^ENG(6920,DA,0))=0
 N ENDCOMP,ENINV,ENSH,ENTEC
 S ENSH=$P($G(^ENG(6920,DA,2)),U)
 S ENTEC=$P($G(^ENG(6920,DA,2)),U,2)
 S ENDCOMP=$P($G(^ENG(6920,DA,5)),U,2)
 I ENDCOMP]"" G COMP
 ;
UNCOMP ;Work order is incomplete
 S:ENSH]"" ^ENG(6920,"AINC",ENSH,9999999999-DA)=""
 Q
COMP ;Work order is complete
 K:ENSH]"" ^ENG(6920,"AINC",ENSH,9999999999-DA)
 I '$D(DIU(0)) S ENINV=$P($G(^ENG(6920,DA,3)),U,8) D:ENINV]"" W^ENEQHS
 Q
 ;
DEL ;Remove from INCOMPLETE WORK ORDER list
 ;Expects DA
 Q:'$D(DA)
 N ENSHKEY
 S ENSHKEY=$P($G(^ENG(6920,DA,2)),U)
 Q:ENSHKEY=""
 K ^ENG(6920,"AINC",ENSHKEY,9999999999-DA)
 Q
 ;
 ;ENWOCOMP
