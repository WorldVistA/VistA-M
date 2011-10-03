ICDHLPD ;ALB/GRR/EG - HELP DISPLAY DIAGNOSIS IDENTIFIERS ; 9/22/04 9:41am
 ;;18.0;DRG Grouper;**10,14,20,24**;Oct 20, 2000;Build 5
EN ;routine revised 12/94
 N ICDID,I,J,ID
 F ID="DXCODE","DNCODE" D
 . F I=1:1 S ICDID=$T(@ID+I),ICDID=$P(ICDID,";;",2) Q:ICDID="EXIT"  D
 .. S ICDID($P(ICDID,"="))=ICDID
 . W ! S I="" F J=0:1 S I=$O(ICDID(I)) Q:I=""  D
 .. I J#3 W ?(J#3*27)
 .. I '(J#3) W !
 .. W ICDID(I)
 . K ICDID
 W !
 Q
MAJ ;display major or procedure identifier
 W !,"1=Bowel",?20,"2=Chest",?50,"3=Lymphoma/Leukemia"
 W !,"4=Joint",?20,"5=Pancreas/Liver",?50,"6=Pelvic"
 W !,"7=Shoulder/Elbow",?20,"8=Thumb/Joint",?50,"9=Head/Neck"
 W !,"A=Cardio",?20,"M=Musculoskeletal",?50,"B=Spine"
 Q
DXCODE ;DIAGNOSIS CODES
 ;;H=any DX
 ;;V=CV cmplctn
 ;;p=prematurity
 ;;F=fem
 ;;J=Maj prblm
 ;;T=Trauma
 ;;A=AMI/CHF
 ;;P=Pruritis
 ;;d=Postpartum
 ;;Y=Mouth,Larynx,Pharynx
 ;;t=Therapy
 ;;r=Breast Malig
 ;;l=Acute leuk.
 ;;E=extrm immtrty
 ;;K=Intracranial Hemorrhage
 ;;R=full term
 ;;O=only
 ;;I=Acute MI
 ;;G=Ganglion
 ;;D=Delivered
 ;;m=hist malig as 2ry dx
 ;;S=Significant problem
 ;;u=antepartum cmplx
 ;;X=cmplx/cmplctd
 ;;a=Adenoidectomy/Tonsillect
 ;;B=abrtn
 ;;b=full thickness burn
 ;;z=not sig 2ry dx
 ;;M=malignancy/Neoplasm
 ;;U=Ulcer/itis
 ;;L=Leukemia/lymphoma
 ;;v=Dx comp vag delivry
 ;;k=infection
 ;;h=HIV
 ;;i=hiv related cond
 ;;j=inhalation injury
 ;;Q=Acute CNS DX
 ;;W=Severe Sepsis
 ;;Z=2ndry HF (2ndry dx of heart failure)
 ;;c=MCV in prime or 2ndry
 ;;s=MCV in 2ndry
 ;;g=major GI dx 
 ;;EXIT
 Q
DNCODE ;  NUMERIC/OTHER ID CODES
 ;;1=coma>1hr
 ;;2=DRG492
 ;;3=DRG480
 ;;4=DRG481
 ;;5=DRG481 w/leuk
 ;;6=DRG546 curvature of spine or malignancy
 ;;*=extensive burn
 ;;EXIT
 Q
