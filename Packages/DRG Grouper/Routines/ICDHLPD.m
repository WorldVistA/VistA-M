ICDHLPD ;ALB/GRR/EG - HELP DISPLAY DIAGNOSIS IDENTIFIERS ; 9/22/04 9:41am
 ;;18.0;DRG Grouper;**10,14,20,24,55**;Oct 20, 2000;Build 20
EN ;routine revised 12/94
 N ICDID,I,J,ID
 F I=1:1 S ICDID=$T(DXCODE+I),ICDID=$E($P(ICDID,";;",2),1,25) Q:ICDID="EXIT"  D
 . S ICDID($P(ICDID,"="))=ICDID
 W ! S I="" F J=0:1 S I=$O(ICDID(I)) Q:I=""  D
 . I J#3 W ?(J#3*27)
 . I '(J#3) W !
 . W ICDID(I)
 K ICDID
 W ! F I=1:1 S ICDID=$T(DNCODE+I),ICDID=$E($P(ICDID,";;",2),1,25) Q:ICDID="EXIT"  D
 . W ?(I-1#3*27) I '(I-1#3) W !
 .W ICDID
 W !
 Q
MAJ ;display major or procedure identifier
 W !,"1=Bowel",?20,"2=Chest",?50,"3=Lymphoma/Leukemia"
 W !,"4=Joint",?20,"5=Pancreas/Liver",?50,"6=Pelvic"
 W !,"7=Shoulder/Elbow",?20,"8=Thumb/Joint",?50,"9=Head/Neck"
 W !,"A=Cardio",?20,"M=Musculoskeletal",?50,"B=Spine"
 Q
DXCODE ;DIAGNOSIS CODES
 ;;A=AMI/CHF
 ;;B=abrtn
 ;;D=Delivered
 ;;E=extrm immtrty
 ;;F=fem
 ;;G=Ganglion
 ;;H=any DX
 ;;I=Acute MI
 ;;J=Maj prblm
 ;;K=Intracranial Hemorrhage
 ;;L=Leukemia/lymphoma
 ;;M=malignancy/Neoplasm
 ;;O=only
 ;;P=Pruritis
 ;;Q=Acute CNS DX
 ;;R=full term
 ;;S=Significant problem
 ;;T=Trauma
 ;;U=Ulcer/itis
 ;;V=CV cmplctn
 ;;W=Severe Sepsis
 ;;X=cmplx/cmplctd
 ;;Y=Mouth,Larynx,Pharynx
 ;;Z=2ndry DX of Heart failur
 ;;a=Adenoidectomy/Tonsillect
 ;;b=full thickness burn
 ;;c=MCV in prime or 2ndry
 ;;d=Postpartum
 ;;g=major GI dx
 ;;h=HIV
 ;;i=hiv related cond
 ;;j=inhalation injury
 ;;k=infection
 ;;l=Acute leuk.
 ;;m=hist malig as 2ry dx
 ;;p=prematurity
 ;;r=Breast Malig
 ;;s=MCV in 2ndry
 ;;t=Therapy
 ;;u=antepartum cmplx
 ;;v=Dx comp vag delivry
 ;;z=not sig 2ry dx
 ;;EXIT
 Q
DNCODE ; NUMERIC/OTHER ID CODES
 ;;1=coma>1hr
 ;;2=DRG492 before10/1/07(CMS) Chemo w acute leukemia as sdx or w high dose chemo agent
 ;;2=DRG 837 after 9/31/07(MS) Chemo w acute leukemia as sdx or w high dose chemo agent
 ;;3=DRG480 before10/1/07(CMS) liver transplant
 ;;3=DRG 005 after 9/31/07(MS) liver transplant
 ;;4=DRG481 before10/1/07(CMS) Bone marrow transplant  
 ;;4=DRG 009 after 9/31/07(MS) TRACH W MV 96+ HRS OR PDX EXC FACE, MOUTH & NECK W/O MAJ O.R
 ;;4=DRG14,15 after 10/1/07 ALLOGENEIC/AUTOLOGOUS BONE MARROW TRANSPLANT
 ;;4=DRG14,16,17 aft 9/31/11 ALLOGENEIC/AUTOLOGOUS BONE MARROW TRANSPLANT
 ;;5=DRG481 w/leuk
 ;;6=DRG546 curvature of spine or malignancy - before 10012007
 ;;6=DRG456 after 9/31/07 - Spinal fus exc cerv w spinal curv/malig/infec or 9+ fus w MCC
 ;;*=extensive burn
 ;;EXIT
 Q
