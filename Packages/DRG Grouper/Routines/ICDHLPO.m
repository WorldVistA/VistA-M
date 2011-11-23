ICDHLPO ;ALB/GRR/EG-HELP DISPLAY FOR OPERATION IDENTIFIERS ; 11/9/07 12:52pm
 ;;18.0;DRG Grouper;**10,14,31**;Oct 20, 2000;Build 7
EN ;revised 12/94  abr
 N ICDID,I,J,ID
 F I=1:1 S ICDID=$T(PXCODE+I),ICDID=$P(ICDID,";;",2) Q:ICDID="EXIT"  D
 . S ICDID($P(ICDID,"="))=ICDID
 W ! S I="" F J=0:1 S I=$O(ICDID(I)) Q:I=""  D
 . I J#3 W ?(J#3*27)
 . I '(J#3) W !
 . W ICDID(I)
 K ICDID
 W ! F I=1:1 S ICDID=$T(PNCODE+I),ICDID=$P(ICDID,";;",2) Q:ICDID="EXIT"  D
 . W ?(I-1#3*27) I '(I-1#3) W !
 .W ICDID
 W !
 Q
PXCODE ; procedure id codes
 ;;H=Cardiac Cath/Angiogr
 ;;N=Non-OR proc.
 ;;E=Common Duct Expl.
 ;;g=other MDC13 OR proc.
 ;;a=other MDC12 OR proc.
 ;;K=Intracranial Vascular
 ;;S=Ventricular Shunt
 ;;T=Total Cholecystect.
 ;;O=OR proc.
 ;;L=Local Excision/Biopsy
 ;;I=Tubal Interruption
 ;;c=Cesarean Section
 ;;n=No compl. OR proc.
 ;;s=Steriliza/postpart D&C
 ;;d=D&C
 ;;z=Non-extensive
 ;;y=Prostatic
 ;;e=Extractns & Restoratns.
 ;;D=Rehab&Detox
 ;;R=Rehab
 ;;P=Valve proc.
 ;;o=DRG108 proc.
 ;;l=Liver
 ;;b=Bypass
 ;;t=Trachea
 ;;B=Bone Marrow
 ;;h=Hepatobiliary
 ;;p=Pacemaker Lead
 ;;m=Subtotal Mastect.
 ;;M=Total Mastectomy
 ;;q=Heart Transplant
 ;;r=Lung Transplant
 ;;u=Proc for trauma
 ;;x=Extensive Procedure
 ;;F=combined spinal fusion
 ;;k=skin graft
 ;;f=other MDC24 OR proc.
 ;;V=Ventilator
 ;;C=Chemo inplant
 ;;Q=Craniotomy
 ;;I=injectable/infusion (injection or infusion of drugs)
 ;;J=Inguinal and femoral hernia procedures
 ;;EXIT
 Q
PNCODE ;numeric ID's for procedures/ operations
 ;;1=Percutaneous
 ;;2=DRG228 proc.
 ;;3=Biliary
 ;;4=DRG232 proc.
 ;;6=DRG106
 ;;7=DRG110
 ;;7=DRG117
 ;;EXIT
 Q
