PRSXP48 ;LLH/WCIOFO-POST INSTALL UPDATE TO FEGLI CODES;3/26/99
 ;;4.0;PAID;**48**;Sep 21, 1995
 ;
 ;4 callable entry points
 ;  1. UPDTFEG - delete FEGLI codes & add NEW codes. Called by
 ;               patch PRS*4*48 post installation.
 ;  2. RSTRFEG - delete new FEGLI codes & restore OLD codes
 ;  3. DELOLD  - delete all existing codes.
 ;  4. ADDFEG(RESTORE) ADD FEGLI codes
 ;
 ; Routine intended 2b temporary. Delete after PRS*4*48 install.
 ;
 Q
 ;==============================================================
UPDTFEG ; UPDATE NEW FEGLI CODES PER VACO.
 ; This entry point will delete all existing FEGLI codes 
 ; from File 454 & then add new codes & descriptions that are changed
 ; by VACO-directive 99-119. 
 ;
 D DELOLD,ADDFEG(0),MSSG
 Q
 ;
 ;==============================================================
RSTRFEG ;RESTORE OLD FEGLI CODES
 ; This entry point restores the FEGLI codes to pre VACO
 ; directive 99-119. Coded for testing and just in case need
 ; to return to the old codes
 ;
 D DELOLD,ADDFEG(1)
 Q
 ;
 ;==============================================================
DELOLD ; DELETE ALL OF THE OLD FEGLI CODES
 ; Loop thru PAID CODE FILES "FEGLI" entry
 ; to delete each entry and associated cross references.
 ; Inner loop ensures any duplicates are deleted.
 ;
 N DIK,REC,DA
 S REC=""
 F  S REC=$O(^PRSP(454,1,"FEG","B",REC)) Q:REC=""  D
 .  S DA=""
 .  F  S DA=$O(^PRSP(454,1,"FEG","B",REC,DA)) Q:DA=""  D
 ..  S DIK="^PRSP(454,1,""FEG"",",DA(1)=1
 ..  D ^DIK
 Q
 ;
 ;==============================================================
ADDFEG(RESTORE) ; ADD FEGLI codes
 ; Input: RESTORE - Flag determines label for codes/descriptions 
 ;           Use old codes if RESTORE=1, otherwise new codes.
 ;                   
 ; Loop thru new codes & descriptions at label NFEG or OFEG
 ; & add to PAID CODE FILES, "FEG" entry.
 ;
 N NEWCODE,CODE,TXT,DIE,DA,DIC,X,DLAYGO,DR
 S RESTORE=$S($G(RESTORE)=1:RESTORE,1:0)
 S (DIC,DIE)="^PRSP(454,1,""FEG"",",DA(1)=1
 F I=1:1 S NEWCODE=$$PICKCODE(RESTORE,I) Q:NEWCODE=""  D
 . K DO,DD
 . S CODE=$P(NEWCODE,";")
 . S X=CODE,DIC(0)="L",DLAYGO=454 D FILE^DICN
 . S DA=+Y
 . S TXT=$P(NEWCODE,";",2)
 . S DR="1///^S X=TXT"
 . D ^DIE
 Q
 ;==============================================================
PICKCODE(RSTOR,LINE) ;function returns text for FEGLI codes
 ; If RSTOR flag > 0 then get old codes otherwise get new.
 Q $S(RSTOR:$P($T(OFEG+LINE),";;",2),1:$P($T(NFEG+LINE),";;",2))
 ;
 ;==============================================================
MSSG ;KIDS POST INSTALLATION MESSAGE.
 D MES^XPDUTL("  Updating FEGLI codes.")
 H 1
 D MES^XPDUTL("  You should delete routine PRSXP48 when installation is complete.")
 H 1
 Q
 ;==============================================================
OFEG ; old FEGLI Codes and Definitions
 ;;A;INELIGIBLE  FOR LIFE INSURANCE COVERAGE
 ;;B;WAIVED      ALL LIFE INSURANCE
 ;;C;BASIC       LIFE ONLY
 ;;D;BASIC       LIFE + STANDARD OPTION
 ;;E;BASIC       LIFE + FAMILY OPTION
 ;;F;BASIC       LIFE + STANDARD OPTION & FAMILY OPTION
 ;;G;BASIC       LIFE + ADDITIONAL OPTION WITH 1 X PAY
 ;;H;BASIC       LIFE + ADDITIONAL OPTION WITH 1 X PAY & STANDARD OPTION
 ;;I;BASIC       LIFE + ADDITIONAL OPTION WITH 1 X PAY & FAMILY OPTION
 ;;J;BASIC       LIFE + ADDITIONAL OPTION WITH 1 X PAY & STANDARD OPTION & FAMILY OPTION
 ;;K;BASIC       LIFE + ADDITIONAL OPTION WITH 2 X PAY
 ;;L;BASIC       LIFE + ADDITIONAL OPTION WITH 2 X PAY & STANDARD OPTION
 ;;M;BASIC       LIFE + ADDITIONAL OPTION WITH 2 X PAY & FAMILY OPTION
 ;;N;BASIC       LIFE + ADDITIONAL OPTION WITH 2 X PAY & STANDARD OPTION & FAMILY OPTION
 ;;9;BASIC       LIFE + ADDITIONAL OPTION WITH 3 X PAY
 ;;P;BASIC       LIFE + ADDITIONAL OPTION WITH 3 X PAY & STANDARD OPTION
 ;;Q;BASIC       LIFE + ADDITIONAL OPTION WITH 3 X PAY & FAMILY OPTION
 ;;R;BASIC       LIFE + ADDITIONAL OPTION WITH 3 X PAY & STANDARD OPTION & FAMILY OPTION
 ;;S;BASIC       LIFE + ADDITIONAL OPTION WITH 4 X PAY
 ;;T;BASIC       LIFE + ADDITIONAL OPTION WITH 4 X PAY & STANDARD OPTION
 ;;U;BASIC       LIFE + ADDITIONAL OPTION WITH 4 X PAY & FAMILY OPTION
 ;;V;BASIC       LIFE + ADDITIONAL OPTION WITH 4 X PAY & STANDARD OPTION & FAMILY OPTION
 ;;W;BASIC       LIFE + ADDITIONAL OPTION WITH 5 X PAY
 ;;X;BASIC       LIFE + ADDITIONAL OPTION WITH 5 X PAY & STANDARD OPTION
 ;;Y;BASIC       LIFE + ADDITIONAL OPTION WITH 5 X PAY & FAMILY OPTION
 ;;Z;BASIC       LIFE + ADDITIONAL OPTION WITH 5 X PAY & STANDARD OPTION & FAMILY OPTION
 ;;O;BASIC       LIFE + ADDITIONAL OPTION WITH 3 X PAY
 ;;
 Q
 ;=============================================================
NFEG ; New FEGLI codes and Descriptions - post Patch 48
 ;;A0;Ineligible
 ;;B0;Waived
 ;;C0;Basic only
 ;;D0;Basic + Option A
 ;;E1;Basic + Option C (1x)
 ;;E2;Basic + Option C (2x)
 ;;E3;Basic + Option C (3x)
 ;;E4;Basic + Option C (4x)
 ;;E5;Basic + Option C (5x)
 ;;F1;Basic + Option A + Option C (1x)
 ;;F2;Basic + Option A + Option C (2x)
 ;;F3;Basic + Option A + Option C (3x)
 ;;F4;Basic + Option A + Option C (4x)
 ;;F5;Basic + Option A + Option C (5x)
 ;;G0;Basic + Option B (1x)
 ;;H0;Basic + Option B (1x) + Option A
 ;;I1;Basic + Option B (1x) + Option C (1x)
 ;;I2;Basic + Option B (1x) + Option C (2x)
 ;;I3;Basic + Option B (1x) + Option C (3x)
 ;;I4;Basic + Option B (1x) + Option C (4x)
 ;;I5;Basic + Option B (1x) + Option C (5x)
 ;;J1;Basic + Option B (1x) + Option A + Option C (1x)
 ;;J2;Basic + Option B (1x) + Option A + Option C (2x)
 ;;J3;Basic + Option B (1x) + Option A + Option C (3x)
 ;;J4;Basic + Option B (1x) + Option A + Option C (4x)
 ;;J5;Basic + Option B (1x) + Option A + Option C (5x)
 ;;K0;Basic + Option B (2x)
 ;;L0;Basic + Option B (2x) + Option A
 ;;M1;Basic + Option B (2x) + Option C (1x)
 ;;M2;Basic + Option B (2x) + Option C (2x)
 ;;M3;Basic + Option B (2x) + Option C (3x)
 ;;M4;Basic + Option B (2x) + Option C (4x)
 ;;M5;Basic + Option B (2x) + Option C (5x)
 ;;N1;Basic + Option B (2x) + Option A + Option C (1x)
 ;;N2;Basic + Option B (2x) + Option A + Option C (2x)
 ;;N3;Basic + Option B (2x) + Option A + Option C (3x)
 ;;N4;Basic + Option B (2x) + Option A + Option C (4x)
 ;;N5;Basic + Option B (2x) + Option A + Option C (5x)
 ;;90;Basic + Option B (3x)
 ;;P0;Basic + Option B (3x) + Option A
 ;;Q1;Basic + Option B (3x) + Option C (1x)
 ;;Q2;Basic + Option B (3x) + Option C (2x)
 ;;Q3;Basic + Option B (3x) + Option C (3x)
 ;;Q4;Basic + Option B (3x) + Option C (4x)
 ;;Q5;Basic + Option B (3x) + Option C (5x)
 ;;R1;Basic + Option B (3x) + Option A + Option C (1x)
 ;;R2;Basic + Option B (3x) + Option A + Option C (2x)
 ;;R3;Basic + Option B (3x) + Option A + Option C (3x)
 ;;R4;Basic + Option B (3x) + Option A + Option C (4x)
 ;;R5;Basic + Option B (3x) + Option A + Option C (5x)
 ;;S0;Basic + Option B (4x)
 ;;T0;Basic + Option B (4x) + Option A
 ;;U1;Basic + Option B (4x) + Option C (1x)
 ;;U2;Basic + Option B (4x) + Option C (2x)
 ;;U3;Basic + Option B (4x) + Option C (3x)
 ;;U4;Basic + Option B (4x) + Option C (4x)
 ;;U5;Basic + Option B (4x) + Option C (5x)
 ;;V1;Basic + Option B (4x) + Option A + Option C (1x)
 ;;V2;Basic + Option B (4x) + Option A + Option C (2x)
 ;;V3;Basic + Option B (4x) + Option A + Option C (3x)
 ;;V4;Basic + Option B (4x) + Option A + Option C (4x)
 ;;V5;Basic + Option B (4x) + Option A + Option C (5x)
 ;;W0;Basic + Option B (5x)
 ;;X0;Basic + Option B (5x) + Option A
 ;;Y1;Basic + Option B (5x) + Option C (1x)
 ;;Y2;Basic + Option B (5x) + Option C (2x)
 ;;Y3;Basic + Option B (5x) + Option C (3x)
 ;;Y4;Basic + Option B (5x) + Option C (4x)
 ;;Y5;Basic + Option B (5x) + Option C (5x)
 ;;Z1;Basic + Option B (5x) + Option A + Option C (1x)
 ;;Z2;Basic + Option B (5x) + Option A + Option C (2x)
 ;;Z3;Basic + Option B (5x) + Option A + Option C (3x)
 ;;Z4;Basic + Option B (5x) + Option A + Option C (4x)
 ;;Z5;Basic + Option B (5x) + Option A + Option C (5x)
 ;;
 Q
