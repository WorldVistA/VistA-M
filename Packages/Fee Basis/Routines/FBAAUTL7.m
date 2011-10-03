FBAAUTL7 ;AISC/CMR,dmk,WCIOFO/SAB-UTILITY ROUTINE ;5/27/1999
 ;;3.5;FEE BASIS;**4**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SCPT ;set "AE" x-ref when SERVICE PROVIDED field is added or modified
 ; called by .01 field of SERVICE PROVIDED multiple in file 162
 ; input
 ;   X     = new value of SERVICE PROVIDED (internal)
 ;   DA    = IEN of entry in SERVICE PROVIDED multiple
 ;   DA(1) = IEN of entry in INITIAL TREATMENT DATE multiple
 ;   DA(2) = IEN of entry in VENDOR multiple
 ;   DA(3) = IEN of PATIENT in file #162
 ;
 Q:'$G(X)
 N FBAADT,Y
 ; obtain current value of INITIAL TREATMENT DATE field from global
 S FBAADT=$P(^FBAAC(DA(3),1,DA(2),1,DA(1),0),U)
 ; build sorted list of CPT modifers from the CPT MODIFIER multiple
 S Y=$$MODL^FBAAUTL4("^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"_DA_",""M"")")
 ; set node in "AE" x-ref
 S ^FBAAC("AE",DA(3),DA(2),FBAADT,X_$S(Y]"":"-"_Y,1:""),DA)=""
 Q
 ;
KCPT ;kill "AE" x-ref when SERVICE PROVIDED field is deleted or modified
 ; called by .01 field of SERVICE PROVIDED multiple in file 162
 ; input
 ;   X     = old value of SERVICE PROVIDED (internal)
 ;   DA    = IEN of entry in SERVICE PROVIDED multiple
 ;   DA(1) = IEN of entry in INITIAL TREATMENT DATE multiple
 ;   DA(2) = IEN of entry in VENDOR multiple
 ;   DA(3) = IEN of PATIENT in file #162
 ;
 Q:'$G(X)
 N CPTM,FBAADT,Y
 ; obtain current value of INITIAL TREATMENT DATE field from global
 S FBAADT=$P(^FBAAC(DA(3),1,DA(2),1,DA(1),0),U)
 ; kill all nodes in x-ref for this SERVICE PROVIDED entry (DA)
 ; Note: Deleting an entry in the SERVICE PROVIDED multiple will
 ; cause the x-ref kill logic of the CPT MODIFIER sub-multiple to be
 ; executed for each modifer before any global updates take place.
 ; Therefore, there can be several nodes to delete by the time the
 ; SERVICE PROVIDED field kill logic is run since each CPT MODIFIER
 ; kill logic will have set a node for any remaining modifiers.
 S CPTM=""
 F  S CPTM=$O(^FBAAC("AE",DA(3),DA(2),FBAADT,CPTM)) Q:CPTM=""  D
 . I $D(^FBAAC("AE",DA(3),DA(2),FBAADT,CPTM,DA)) K ^(DA)
 Q
 ;
SMOD ;set "AE" x-ref when CPT MODIFIER is added or modified
 ; called by .01 field of CPT MODIFIER multiple in file 162
 ; input
 ;   X     = new value of CPT MODIFIER (internal)
 ;   DA    = IEN of entry in CPT MODIFIER multiple
 ;   DA(1) = IEN of entry in SERVICE PROVIDED multiple
 ;   DA(2) = IEN of entry in INITIAL TREATMENT DATE multiple
 ;   DA(3) = IEN of entry in VENDOR multiple
 ;   DA(4) = IEN of PATIENT in file #162
 ;
 Q:'$G(X)
 N FBAADT,FBAACP,FBMODA,Y
 ; obtain current value of INITIAL TREATMENT DATE field
 S FBAADT=$P(^FBAAC(DA(4),1,DA(3),1,DA(2),0),U)
 ; obtain current value of SERVICE PROVIDED field
 S FBAACP=$P($G(^FBAAC(DA(4),1,DA(3),1,DA(2),1,DA(1),0)),U)
 ; obtain array of modifiers in global for CPT MODIFIER multiple
 D MODDATA^FBAAUTL4(DA(4),DA(3),DA(2),DA(1))
 ;
 ; when a new/changed modifier is entered, the x-ref that previously
 ; existed will need to be deleted.
 ;   remove node associated with new/changed modifier from array
 K FBMODA(DA)
 ;   build sorted list of modifiers without the new/changed modifier
 S Y=$$MODL^FBAAUTL4("FBMODA")
 ;   kill existing x-ref node (if any) for the service
 K:$D(^FBAAC("AE",DA(4),DA(3),FBAADT,FBAACP_$S(Y]"":"-"_Y,1:""),DA(1))) ^(DA(1))
 ;
 ; now create a node in the x-ref for the new/changed value
 ;   add new/changed modifier to modifier array
 S FBMODA(DA)=X
 ;   build sorted list of all modifiers
 S Y=$$MODL^FBAAUTL4("FBMODA")
 ;   set x-ref node
 S ^FBAAC("AE",DA(4),DA(3),FBAADT,FBAACP_"-"_Y,DA(1))=""
 Q
 ;
KMOD ;kill "AE" x-ref when CPT MODIFIER is deleted or modified
 ; called by .01 field of CPT MODIFIER multiple in file 162
 ; input
 ;   X     = old value of CPT MODIFIER (internal)
 ;   DA    = IEN of entry in CPT MODIFIER multiple
 ;   DA(1) = IEN of entry in SERVICE PROVIDED multiple
 ;   DA(2) = IEN of entry in INITIAL TREATMENT DATE multiple
 ;   DA(3) = IEN of entry in VENDOR multiple
 ;   DA(4) = IEN of PATIENT in file #162
 ;
 Q:'$G(X)
 N FBAADT,FBAACP,FBMODA,Y
 ; obtain current value of INITIAL TREATMENT DATE field
 S FBAADT=$P(^FBAAC(DA(4),1,DA(3),1,DA(2),0),U)
 ; obtain current value of SERVICE PROVIDED field
 S FBAACP=$P($G(^FBAAC(DA(4),1,DA(3),1,DA(2),1,DA(1),0)),U)
 ; obtain array of modifiers in global for CPT MODIFIER multiple
 D MODDATA^FBAAUTL4(DA(4),DA(3),DA(2),DA(1))
 ;
 ; if a CPT modifier was deleted or changed then we need to delete
 ; the x-ref for the old value
 ;   overwrite node in array for the deleted/changed CPT modifier since
 ;   the global may have already been updated
 S FBMODA(DA)=X
 ;   build sorted list of CPT modifiers
 S Y=$$MODL^FBAAUTL4("FBMODA")
 ;   kill existing x-ref node
 K:$D(^FBAAC("AE",DA(4),DA(3),FBAADT,FBAACP_$S(Y]"":"-"_Y,1:""),DA(1))) ^(DA(1))
 ;
 ; if a CPT modifier was deleted then we need to set a x-ref node for
 ; procedure and any remaining modifiers.  Note that during a change
 ; the set logic is run after the kill logic and it will delete the
 ; x-ref node created here before setting a node for the new value.
 ;   remove deleted/changed modifier from array
 K FBMODA(DA)
 ;   build sorted list of remaining modifiers
 S Y=$$MODL^FBAAUTL4("FBMODA")
 ;   set x-ref node
 S ^FBAAC("AE",DA(4),DA(3),FBAADT,FBAACP_$S(Y]"":"-"_Y,1:""),DA(1))=""
 Q
 ;
 ;FBAAUTL7
