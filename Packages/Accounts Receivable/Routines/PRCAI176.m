PRCAI176 ;WOIFO/AAT-POST-INSTALL ROUTINE PATCH PRCA*4.5*176 ;08-Feb-02
 ;;4.5;Accounts Receivable;**176**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
 Q
 ;
DATA ;;Only "CATEGORY NUMBER" (piece 8 here) are to be changed in the file!
 ;;33^ADULT DAY HEALTH CARE^AD^0^1319^^P^40^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 ;;34^DOMICILIARY^DO^0^1319^^P^41^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 ;;35^RESPITE CARE-INSTITUTIONAL^RC^0^1319^^P^42^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 ;;36^RESPITE CARE-NON-INSTITUTIONAL^RN^0^1319^^P^43^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 ;;37^GERIATRIC EVAL-INSTITUTIONAL^GE^0^1319^^P^44^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70        
 ;;38^GERIATRIC EVAL-NON-INSTITUTION^GN^0^1319^^P^45^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 ;;39^NURSING HOME CARE-LTC^NL^0^1319^^P^46^2^1^1^1^1^2^30,40,55,80,85,50,60,65,70
 Q
RUN N PRMSG,PRI,PRL,PRERR,PRCNT,PROK,PRIEN,PRNAME,PRNUM,PRFILE
 S PRFILE=430.2
 D MSG("\n  PRCA*4.5*176 Post-Install .....")
 D MSG("\n  Making changes in ACCOUNTS RECEIVABLE CATEGORY file #"_PRFILE_" ...")
 D MSG("\nIEN     NAME                   CATEGORY NUMBER    CHECK")
 D MSG("--------------------------------------------------------")
 S PRCNT=0 ; Records counter
 S PRERR=0 ; Errors counter
 F PRI=1:1 S PRL=$P($T(DATA+PRI),";;",2,255) Q:'PRL  D
 . S PRIEN=$P(PRL,U,1)
 . S PRNAME=$P(PRL,U,2)
 . S PRNUM=$P(PRL,U,8)
 . ; Check name of the record to be change (and the presence of the record)
 . S PROK=$$PRECHK(PRIEN,PRNAME) D:PROK
 .. D UPDATE(PRIEN,PRNUM) S PRCNT=PRCNT+1
 .. S PROK=$$POSTCHK(PRIEN,PRNUM) ; Check changes
 . I 'PROK S PRERR=PRERR+1
 . D OUTPUT ; Give a message
 I 'PRERR S PRMSG=PRCNT_" records have been updated successfully"
 E  I PRERR=PRCNT S PRMSG="Warning! File #"_PRFILE_" was not updated due to errors"
 E  S PRMSG="Warning! "_PRERR_" records were not updated due to errors"
 D MSG("\n"_PRMSG)
 Q
OUTPUT N PRMSG,PRRES,PRNAM2
 S PRRES=$S(PROK:"OK",1:"Error")
 S PRNAM2=$$NAME(PRIEN,PRNAME)
 S PRMSG=$J(PRIEN,2)_"  "_PRNAM2_$J("",35-$L(PRNAM2))_"  "_$J(PRNUM,2)_$J("",8)_PRRES
 D MSG(PRMSG)
 Q
 ; Change data
UPDATE(PRIEN,PRNUM) N PRRT,PRERR
 S PRRT(PRFILE,PRIEN_",",6)=PRNUM
 D FILE^DIE("K","PRRT","PRERR")
 Q
 ; Pre-check - does the name conform?
PRECHK(PRIEN,PRNAME) ;
 Q $P($G(^PRCA(PRFILE,PRIEN,0)),U,1)=PRNAME
 ; Post-check - have the change appeared?
POSTCHK(PRIEN,PRNUM) ;
 Q $P($G(^PRCA(PRFILE,PRIEN,0)),U,7)=PRNUM
 ;
MSG(PRTXT) N PRMSG,PRI
 F PRI=1:1:$L(PRTXT,"\n") S PRMSG(PRI)=$P(PRTXT,"\n",PRI)
 D MES^XPDUTL(.PRMSG)
 Q
 ;Get the current name, but if it's empty - use default
NAME(PRIEN,PRDFLT) N PRNM
 S PRNM=$P($G(^PRCA(PRFILE,PRIEN,0)),U)
 Q $S(PRNM="":$G(PRDFLT),1:PRNM)
 ; For testing only - remove values
CLEAR N PRI,PRL,PRFILE
 S PRFILE=430.2
 F PRI=1:1 S PRL=+$P($T(DATA+PRI),";;",2) Q:'PRL  D UPDATE(PRL,0)
 W !,"Records now have 0 settings!"
 Q
