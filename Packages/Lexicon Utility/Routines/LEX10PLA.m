LEX10PLA ;ISL/KER - ICD-10 Procedure Lookup Abbreviations ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 Q
SH(X,Y) ; Shorten Text
 S X=$G(X) N LEXL S LEXL=+($G(Y)) Q:+LEXL'>0 X
 S X=$$SW(X,"Performance Intensity Phonetically Balanced Speech Discrim","Perf Inten Phonetic Bal Speech Discr") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Lateral Transverse Process Approach, Posterior Column","Lat Trans Proc App, Posterior Column") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Application/Use/Care of Assist/Adapt/Support/Protect Devices","Application/Use/Care of Devices") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Assistive, Adaptive, Supportive or Protective","Assist/Adapt/Support/Protect") Q:$L(X)'>LEXL X
 S X=$$SW(X," and "," & ") Q:$L(X)'>LEXL X
 S X=$$SW(X," / ","/") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Assistive, Adaptive,Supportive or Protective","Assist/Adapt/Support/Protect") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Application, Proper Use & Care","Application/Use/Care") Q:$L(X)'>LEXL X
 S X=$$SW(X," - Lower Back/Lower Extremity","-Lower Back/Extrem") Q:$L(X)'>LEXL X
 S X=$$SW(X," - Upper Back/Upper Extremity","-Upper Back/Extrem") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Electroacoustic","Elctacou.") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Acoustic","Acou.") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Listening","Listen") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Devices","Dev") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Device","Dev") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Vocational","Voc") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Activities","Act") Q:$L(X)'>LEXL X
 S X=$$SW(X," Check"," Chk") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Other","Oth") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Alternate","Alt") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Nuclear","Nuc") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Medicine","Med") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Imaging","Img") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Balanced","Bal") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Balance","Bal") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Loudness","Loud") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Intraoperative","Intraoper") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Particulate","Particul.") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Substance","Subst") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Screening","Screen") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Diagnostic","Diag") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Endoscopic","Endo") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Endoscopy","Endo") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Circulation","Circul.") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Communication","Comm") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Community/Work","Comm") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Irrigation","Irrigat.") Q:$L(X)'>LEXL X
 S X=$$SW(X," Systems"," Sys") Q:$L(X)'>LEXL X
 S X=$$SW(X," System"," Sys") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Anatomical ","Anat. ") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Subcutaneous","Subcut.") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Extremity","Extrem") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Extremities","Extrem") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Musculoskeletal","Musclskel") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Disorders","Dis") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Communicative","Comm") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Cognitive","Cog") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Awareness","Aware") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Processing","Process") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Positive","Pos") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Negative","Neg") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Multiple","Mult") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Natural or Artificial","Nat/Artif") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Natural/Artificial","Nat/Artif") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Physical","Phys") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Rehabilitation","Rehab") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Audiology","Audio") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Instrumental","Instr") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Swalowing","Swallow") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Performance","Perf") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Phonetically","Phonetic") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Intensity","Inten") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Performance","Perf") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Discrim","Discr") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Processing","Process") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Central","Cent") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Auditory","Audi") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Assessment","Assess") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Language","Lang") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Pathology","Path") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Counseling","Coun") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Prevention","Prev") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Abdominal","Abd") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Unilateral","Unil") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Bilateral","Bil") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Bile Ducts & Pancreatic Ducts","Bile & Pancreatic Ducts") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Positron","Pos") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Arteries","Art") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Artery","Art") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Left","Lt") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Right","Rt") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Skeleton","Skel") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Tissue & Fascia","Tissue/Fascia") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Anterior","Ant") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Posterior","Post") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Myocutaneous","Myocut") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Recombinant","Recomb") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Except","Exc") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Nonautologous","Nonauto") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Stabilization","Stab") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Synthetic","Syn") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Substitute","Sub") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Percutaneous","Percut") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Opening","Open") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Single","Sin") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Channel","Chan") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Prosthesis","Prost") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Transverse","Transv") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Inferior","Infer") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Deep","Dp") Q:$L(X)'>LEXL X
 S X=$$SW(X,"LEXLgthening","LEXLgthen") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Endo Assist","Endo Ast") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Interspinous","Interspin") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Mult Chan","Mul Chan") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Perforator","Perfor") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Superficial","Superfic") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Resynchronization","Resync") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Defibrillator","Defib") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Generator","Gen") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Stimulator","Stim") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Rechargeable","Recharg") Q:$L(X)'>LEXL X
 S X=$$SW(X,"Responsive","Respon") Q:$L(X)'>LEXL X
 Q X
SW(LEX,X,Y) ;   Swap Word X for Word Y
 S LEX=$G(LEX),X=$G(X),Y=$G(Y) Q:'$L(LEX)  Q:'$L(X)
 F  Q:LEX'[X  S:LEX[X LEX=$P(LEX,X,1)_Y_$P(LEX,X,2,299)
 S X=LEX
 Q X
