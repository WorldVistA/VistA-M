LRMIEDIS ;BPFO/DTG - LAB MICRO - ETIOLOGY FIELD FILE 61.2 FOR INACTIVE DATE ;08/15/2017
 ;;5.2;LAB SERVICE;**495**;Sep 27, 1994;Build 6
 ;
 ; uses input template [LRMIETI INACTIVE DATE]
 ;
 ; allows the Micro Supervisor or LIM to edit the Inactive Date field (#64.9102) in
 ; the Etiology Field File
 ;
 Q
 ;
EN ; Edit the Inactive Date
 N LRETIDONE,MSG
 D INFO S LRETIDONE=0
 F  Q:LRETIDONE  D
 . N DIE,DA,DR,DIC,X,Y,DIR,DUOUT,LRETI,Y,X
 . N LRETINAM,LR0,LR6491,LXA,LXB,DIQ,DTOUT
 . ;
 . S LRETI=$$GETETI(.LRETIDONE) Q:$G(LRETIDONE)  ; Get Etiology IEN
 . ; get 61.2 info
 . ; .01 - NAME, 2 - SNOMED CODE, 3 - GRAM STAIN, 4 - IDENTIFIER, 64.9102 - INACTIVE DATE
 . S DA=LRETI,DIQ="LXB",DIQ(0)="IE",DIC=61.2,DR=".01;2;3;4;64.9102" D EN^DIQ1
 . K LXA M LXA=LXB(61.2,DA) K LXB
 . ; Print info
 . W !!,"Organism: ",$G(LXA(.01,"E")),!,"Snomed Code: ",$G(LXA(2,"E")),?25,"Gram Stain: ",$G(LXA(3,"E"))
 . W !,"Identifier: ",$G(LXA(4,"E")),?28,"Inactive Date: ",$G(LXA(64.9102,"E")),!
 . ; use input template
 . K DIE,DTOUT,DR,Y,X
 . S DIE="^LAB(61.2,"
 . S DR="[LRMIETI INACTIVE DATE]"
 . S DA=LRETI
 . S DIE("NO^")="OUTOK"
 . D ^DIE
 . ;set done flag if '^' is entered while asking date
 . I $D(Y) S LRETIDONE=1 Q
 . ;
 G OUT
 ;
GETETI(LRETIDONE)  ; Prompt user for Etiology Field file (#61.2) entry
 N DIC
 S DIC=61.2,DIC(0)="QEAMZ"
 W ! D ^DIC I Y<0  S LRETIDONE=1 Q ""  ; Nothing selected, quit
 S LRETI=+Y,LRETINAM=$P(Y,"^",2)
 Q LRETI
 ;
INFO ; Display message, clear screen
 N MSG
 S MSG(1)="   This option allows the editing of the INACTIVE DATE field"
 S MSG(2)="   in the ETIOLOGY FIELD File (#61.2)."
 S MSG(3)=""
 D CLEAR^VALM1
 D BMES^XPDUTL(.MSG)
 Q
 ;
OUT ; quit point
 K LRETIDONE,MSG
 Q
