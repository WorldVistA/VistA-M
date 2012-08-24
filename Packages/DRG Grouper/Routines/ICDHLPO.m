ICDHLPO ;ALB/GRR/EG-HELP DISPLAY FOR OPERATION IDENTIFIERS ; 11/9/07 12:52pm
 ;;18.0;DRG Grouper;**10,14,31,55**;Oct 20, 2000;Build 20
EN ;revised 12/94 abr
 N ICDID,I,J,ID
 F I=1:1 S ICDID=$T(PXCODE+I),ICDID=$E($P(ICDID,";;",2),1,25) Q:ICDID="EXIT"  D
 . S ICDID($P(ICDID,"="))=ICDID
 W ! S I="" F J=0:1 S I=$O(ICDID(I)) Q:I=""  D
 . I J#3 W ?(J#3*27)
 . I '(J#3) W !
 . W ICDID(I)
 K ICDID
 W ! F I=1:1 S ICDID=$T(PNCODE+I),ICDID=$E($P(ICDID,";;",2),1,25) Q:ICDID="EXIT"  D
 . W ?(I-1#3*27) I '(I-1#3) W !
 .W ICDID
 W !
 Q
PXCODE ; procedure id codes
 ;;A=Amputation
 ;;B=Bone Marrow 
 ;;C=Chemo inplant
 ;;D=Rehab&Detox
 ;;E=Common Duct Expl.
 ;;F=combined spinal fusion
 ;;H=Cardiac Cath/Angiogr
 ;;I=Tubal Interruption
 ;;J=Inguinal and femoral hernia procedures 
 ;;K=Intracranial Vascular
 ;;L=Local Excision/Biopsy
 ;;M=Total Mastectomy
 ;;N=Non-OR proc.
 ;;O=OR proc
 ;;P=Valve proc.
 ;;Q=Craniotomy
 ;;R=Rehab
 ;;S=Ventricular Shunt
 ;;T=Total CHOLECYSTECTOMY
 ;;V=Ventilator
 ;;Z=Stent procedures
 ;;a=other MDC12 OR proc. - MALE REPRODUCTIVE SYSTEM
 ;;b=Bypass
 ;;c=Cesarean Section
 ;;d=D&C
 ;;e=Extractns & Restoratns.
 ;;f=other MDC24 OR proc.- MULTIPLE SIGNIFICANT TRAUMA
 ;;g=other MDC13 OR proc. - FEMALE REPRODUCTIVE SYSTEM 
 ;;h=Hepatobiliary
 ;;i=injectable/infusion (injection or infusion of drugs)
 ;;k=skin graft
 ;;l=Liver
 ;;m=Subtotal Mastect.
 ;;n=No compl. OR proc.
 ;;o=DRG108 proc.before10/1/07(CMS)-Other cardiothoracic procedures
 ;;o=DRG228 after 9/31/07(MS)-Other cardiothoracic procedures
 ;;p=Pacemaker Lead
 ;;q=Heart Transplant
 ;;r=Lung Transplant
 ;;s=Steriliza/postpart D&C
 ;;t=Trachea 
 ;;u=Proc for trauma
 ;;x=Extensive Procedure
 ;;y=Prostatic
 ;;z=Non-extensive
 ;;EXIT
 Q
PNCODE ;numeric ID's for procedures/ operations
 ;;1=Percutaneous procedure done through the skin
 ;;2=DRG228-before10/1/07(CMS)- Major thumb or joint procedures
 ;;2=DRG506 after 9/31/07(MS)- Major thumb or joint procedures
 ;;3=Biliary
 ;;4=DRG232 before10/1/07(CMS)-Arthroscopy
 ;;4=DRG509 after 9/31/07(MS)-Arthroscopy
 ;;6=DRG106 before10/1/07(CMS)-coronary bypass
 ;;6=DRG231 after 9/31/07(MS)-coronary bypass
 ;;7=DRG110,117 before10/1/07(CMS)-Major cardiovasc procedures or thoracic aortic anuerysm repair
 ;;7=DRG237,260 after 9/31/07(MS)-Major cardiovasc procedures or thoracic aortic anuerysm repair
 ;;EXIT
 Q
