YS202TXT ;BAL/KTL - Patch 202 Post-Init Interpretive Text ; Apr 01, 2021@16:31
 ;;5.01;MENTAL HEALTH;**202**;Dec 30, 1994;Build 47
 ;
 ;
 Q
UPDINTRP ; Update the INTERPRETIVE TEXT field
 N YSARR,I,X,INST,IEN,TXT,CNT,XINST,REC
 F I=1:1 S X=$P($T(INTERPS+I),";;",2,99) Q:X="zzzzz"  D
 . S INST=$P(X,";"),TXT=$P(X,";",2,99)
 . I INST]"" S IEN=$O(^YTT(601.71,"B",INST,"")),CNT=0,XINST=INST K YSARR
 . Q:+IEN=0
 . I TXT="***END INTERP***" D  Q
 .. S REC(110)="YSARR"
 .. D FMUPD^YTXCHGU(601.71,.REC,IEN)
 .. D MES^XPDUTL("Adding INTERPRETIVE TEXT to "_XINST)
 .. K YSARR,IEN
 . S CNT=CNT+1,YSARR(CNT)=TXT
 Q
 ;
INTERPS ; Instrument Intepretive Text
 ;;AUDC;  Guide for interpreting AUDC scores (range 0-12):
 ;;;
 ;;;   In men, a score of 4, or more, is considered positive; 
 ;;;   in women, a score of 3, or more, is considered positive.
 ;;;***END INTERP***
 ;;AUDIT;  Guide for interpreting AUDIT scores (range 0-41):
 ;;;
 ;;;   A score of 8, or more, indicates a strong likelihood of hazardous or 
 ;;;   harmful alcohol consumption.
 ;;;***END INTERP***
 ;;BAI;  Guide for interpreting BAI scores (range 0-63):
 ;;;
 ;;;   0-7: Minimal level of anxiety. 8-15: Mild anxiety. 16-25: Moderate anxiety. 26-63: Severe anxiety.
 ;;;***END INTERP***
 ;;BDI2;  Guide for interpreting BDI2 scores (range 0-63):
 ;;;
 ;;;   0-13: Minimal level of depression. 14-19: Mild depression. 20-28: Moderate depression. 29-63: Severe depression.
 ;;;***END INTERP***
 ;;CAGE;  Guide for interpreting CAGE (range 0-4):
 ;;;
 ;;;   A total score of 2, or greater, is considered clinically significant.
 ;;;***END INTERP***
 ;;PCLC;  The PTSD Check List (Civilian) contains the 17 symptoms 
 ;;;   of the DSM-IV diagnosis of PTSD. A high score means the PTSD symptoms were 
 ;;;   endorsed (range 17-85).
 ;;;***END INTERP***
 ;;PCLM;  The PTSD Check List (Military) contains the 17 symptoms 
 ;;;   of the DSM-IV diagnosis of PTSD. A high score means the PTSD symptoms were 
 ;;;   endorsed (range 17-85).
 ;;;***END INTERP***
 ;;PHQ9;  Guide for interpreting PHQ-9 scores (range 0-27):
 ;;;
 ;;;   1-4: The score suggests minimal depression
 ;;;   5-9: Mild depression
 ;;;   10-14 Moderate depression
 ;;;   15-19 Moderately severe depression
 ;;;   20-27 Severe depression
 ;;;***END INTERP***
 ;;SF36;  Guide for interpreting SF-36 scores (range 2-100):
 ;;;
 ;;;   A high value indicates a response toward good health, a low value 
 ;;;   indicates responses toward poor health.
 ;;;***END INTERP***
 ;;SMAST;  Guide for interpreting SMAST scores (range 0-13):
 ;;;
 ;;;   Two points indicate a possible problem. Three points indicate a probable problem.
 ;;;***END INTERP***
 ;;ZUNG;  Guide for interpreting ZUNG scores (range 25-80):
 ;;;
 ;;;   25-49: Normal range. 50-59: Mildly depressed. 60-69: Moderately depressed. 
 ;;;   70 and above: Severely Depressed.
 ;;;***END INTERP***
 ;;PC PTSD;  Guide for interpreting PC PTSD (range 0-4):
 ;;;
 ;;;   A total score of 3, or greater, is considered positive.
 ;;;***END INTERP***
 ;;COWS;  Guide for interpreting COWS (range 0-67):
 ;;;
 ;;;   The higher the score, the greater the withdrawal symptoms. 
 ;;;   Less than 12: Mild. 13-24: Moderate. 
 ;;;   25-36 Moderately severe. Above 36: Severe.
 ;;;***END INTERP***
 ;;BOMC;  Guide for interpreting BOMC scores (range 0-28):
 ;;;
 ;;;   A score greater than 10 is consistent with the presence of dementia. 
 ;;;   Values less than 7 are considered normal for the elderly.
 ;;;***END INTERP***
 ;;PHQ-2;  Guide for interpreting PHQ-2 scores (range 0-6):
 ;;;
 ;;;   0-2: The score suggests the patient may not need depression treatment. 
 ;;;   3-6: A score greater than 2 may indicate a depressive disorder.
 ;;;***END INTERP***
 ;;BRADEN SCALE;  Guide for interpreting BRADEN scores (range 0-23):
 ;;;
 ;;;   A low score means high risk for a pressure ulcer: 
 ;;;   9 or lower: Severe risk. 10-12: High risk. 13-14: Moderate risk. 15-18 Mild risk.
 ;;;***END INTERP***
 ;;ZBI SHORT;  Guide for interpreting ZBI Short Version scores (range 0-48):
 ;;;
 ;;;   A score of 17, or higher, reflects a high burden and needs follow up.
 ;;;***END INTERP***
 ;;ZBI SCREEN;  Guide for interpreting ZBI Screening scores (range 0-16):
 ;;;
 ;;;   A score of 8, or higher, reflects a high burden and needs follow up.
 ;;;***END INTERP***
 ;;GDS;  Guide for interpreting GDS (range 0-15):
 ;;;
 ;;;   The higher the score, the greater the depression. Scores greater than 
 ;;;   5 suggest depression (be sure to follow up). 
 ;;;   Scores greater than 10 indicates depression.
 ;;;***END INTERP***
 ;;GAF;  Guide to interpreting of GAF scores (range 0-100):
 ;;;
 ;;;   A high value indicates high level of functioning, a low value indicates low level of functioning.
 ;;;***END INTERP***
 ;;PCL-5;  Guide for interpreting the PCL-5 (range 0-80):
 ;;; 
 ;;;   0-10: no or minimal symptoms reported,  11-20: mild symptoms reported
 ;;;   21-40: moderate symptoms reported,  21-60 severe symptoms reported,
 ;;;   61-80: very severe symptoms reported.
 ;;;***END INTERP***
 ;;PCLS;  The PTSD Check List (Specific) contains the 17 symptoms 
 ;;;   of the DSM-IV diagnosis of PTSD. A high score means the PTSD symptoms were 
 ;;;   endorsed (range 17-85).
 ;;;***END INTERP***
 ;;GDS DEMENTIA;  Guide for interpreting GDS Dementia (range 1-7):
 ;;;
 ;;;   The higher the score, the greater the dementia. 1 - no cognitive decline,
 ;;;   2 - very mild decline, 3 - mild decline, 4 - moderate decline, 5 - moderate 
 ;;;   severe decline, 6 - severe decline, 7 - very severe decline.
 ;;;***END INTERP***
 ;;CDR;  Guide for interpreting CDR (range 0-3):
 ;;;
 ;;;   A score of 0 indicates no dementia, 0.5 - questionable, 1 - mild, 
 ;;;   2 - moderate, 3 - severe dementia. 
 ;;;***END INTERP***
 ;;FAST;  Guide for interpreting FAST (range 1-7):
 ;;;
 ;;;   The higher the score, the greater the dementia. 1 - normal adult, 
 ;;;   2 - normal older adult, 3 - early dementia, 4 - mild dementia, 5 - moderate 
 ;;;   dementia, 6 - moderate severe dementia, 7 - severe dementia.
 ;;;***END INTERP***
 ;;ASSIST-WHOV3;  Guide for interpreting ASSIST scores (range 0-39):
 ;;;
 ;;;   A Score of 27+ indicates a high health risk,
 ;;;   Moderate health risk, 4 - 26,
 ;;;   Low health risk, 0 - 3.
 ;;;***END INTERP***
 ;;SLUMS;  Guide for interpreting SLUMS scores (range 1-30):
 ;;;
 ;;;   Low score (1-20) indicates dementia, Mild neurocognitive disorder (21-26), 
 ;;;   high score (27-30) is normal functioning.
 ;;;***END INTERP***
 ;;GAD-7;  Guide to interpreting of GAD-7 scores (range 0-21):
 ;;;
 ;;;   A high value indicates high level of anxiety; scores of 5, 10 and 15 indicate 
 ;;;   cutoffs scores for mild, moderate and severe anxiety, respectively.
 ;;;***END INTERP***
 ;;POQ;  Guide for interpreting POQ scores (range 0-200):
 ;;;
 ;;;   The higher the score, the greater problems with pain. 
 ;;;***END INTERP***
 ;;BAM;  Guide for interpreting BAM scores (range 0-24):
 ;;;
 ;;;   A high score on the subscales Use (above 0) and Risk Factors (above 11) calls for further examination. 
 ;;;   A score below 13 on Protective Factors is clinically significant.
 ;;;***END INTERP*** 
 ;;PCL-SZ;  The PTSD Check List (Specific) contains the 17 symptoms 
 ;;;   of the DSM-IV diagnosis of PTSD. A high score means the PTSD symptoms were 
 ;;;   endorsed (range 0-68).
 ;;;***END INTERP***
 ;;IADL;  Guide for interpreting INDEX OF ADL (range 6-18):
 ;;;
 ;;;   The higher the score, the greater the independence. 
 ;;;***END INTERP***
 ;;WHODAS 2;  Guide for interpreting domain scores (range 0-100):
 ;;;
 ;;;   A high value indicates disability, a low value 
 ;;;   indicates no disability.
 ;;;***END INTERP***
 ;;BAM-C;  Guide for interpreting BAM-C scores (range 0-30):
 ;;;
 ;;;   High scores indicate greater use. A score of one or greater is clinically significant.
 ;;;***END INTERP***
 ;;BAM-R;  Guide for interpreting BAM-R scores (range 0-180):
 ;;;
 ;;;   A high score on the subscales Use (above 0) and Risk Factors (above 11) calls for further examination. 
 ;;;   A score below 13 on Protective Factors is clinically significant.
 ;;;***END INTERP***
 ;;BAM-IOP;  Guide for interpreting BAM-IOP scores (range 0-24):
 ;;;
 ;;;   A high score on the subscales Use (above 0) and Risk Factors (above 11) calls for further examination. 
 ;;;   A score below 13 on Protective Factors is clinically significant.
 ;;;***END INTERP***
 ;;CIWA-AR-;  Guide for interpreting CIWA-AR (range 0-67):
 ;;;
 ;;;   The higher the score, the greater the withdrawal symptoms. 
 ;;;   Less than 9: Minimal. 10-19: Mild to Moderate. 20 or more: Severe.
 ;;;***END INTERP***
 ;;EHS-14;Guide for interpreting EHS-14 scores (range 0-10):
 ;;; Higher scores indicate higher levels of Employment Hope.
 ;;;***END INTERP***
 ;;PEBS-27;Guide for interpreting PEBS-27 scores (range 1-5):
 ;;; Higher scores indicate higher perception of Employment Barriers.
 ;;;***END INTERP***
 ;;PEBS-20;Guide for interpreting PEBS-20 scores (range 1-5):
 ;;; Higher scores indicate higher perception of Employment Barriers.
 ;;;***END INTERP***
 ;;ASRS;Guide for interpreting ASRS scores (range 0-25):
 ;;; A score of 14 or higher is considered clinically significant.
 ;;;***END INTERP***
 ;;DAR-5;Guide for interpreting DAR-5 scores (range 5-25):
 ;;; A total score of 12 or above suggests the patient might benefit from further assessment.
 ;;;***END INTERP***
 ;;CIA;Guide for interpreting CIA scores (range 0-48):
 ;;; A score of 16 or greater may be used to predict eating disorder case status.
 ;;;***END INTERP***
 ;;zzzzz
 ;
 Q
