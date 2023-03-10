IBDEI00E ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^Partially Vaccinated for COVID-19
 ;;^UTILITY(U,$J,358.3,289,1,4,0)
 ;;=4^Z28.311
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^5161577
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=Z28.39^^3^22^3
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^Underimmunization Status,Other
 ;;^UTILITY(U,$J,358.3,290,1,4,0)
 ;;=4^Z28.39
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^5161578
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=E66.9^^3^23^5
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,291,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=M81.0^^3^23^6
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^Osteoporosis,Age-Related,w/o Current Fracture
 ;;^UTILITY(U,$J,358.3,292,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,292,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=R87.619^^3^23^1
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^Abnormal Cytology Findings from Cervix Uteri Specimen
 ;;^UTILITY(U,$J,358.3,293,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,293,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=Z79.890^^3^23^7
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^Postmenopausal Hormone Replacement Therapy
 ;;^UTILITY(U,$J,358.3,294,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,294,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=Z30.09^^3^23^2
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^Contraception Counseling/Advice
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=Z15.01^^3^23^3
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^Genetic Susceptibility to Malig Neop Breast
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^Z15.01
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^331591
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=Z15.02^^3^23^4
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^Genetic Susceptibility to Malig Neop Ovary
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^Z15.02
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^331592
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=R45.851^^3^24^3
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=T14.91XA^^3^24^4
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Suicide Attempt,Initial Encntr
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^T14.91XA
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5151779
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=T14.91XD^^3^24^6
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Suicide Attempt,Subsequent Encntr
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^T14.91XD
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^5151780
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=T14.91XS^^3^24^5
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Suicide Attempt,Sequela
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^T14.91XS
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5151781
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=Z91.52^^3^24^1
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^Personal Hx of Non-Suicidal Self-Harm
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^Z91.52
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^5161318
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=Z91.51^^3^24^2
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^Personal Hx of Suicidal Behavior     
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^Z91.51
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5161317
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=90632^^4^25^11^^^^1
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,304,1,2,0)
 ;;=2^90632
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^Hepatitis A Vaccine
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=90746^^4^25^13^^^^1
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,305,1,2,0)
 ;;=2^90746
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Hepatitis B Vaccine
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=90636^^4^25^12^^^^1
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,306,1,2,0)
 ;;=2^90636
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Hepatitis A&B Vaccine
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=90707^^4^25^14^^^^1
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,307,1,2,0)
 ;;=2^90707
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^MMR Virus
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=90658^^4^25^4^^^^1
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,308,1,2,0)
 ;;=2^90658
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Flu Vaccine Multi Dose Vial (Afluria IIV3)
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=90732^^4^25^17^^^^1
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,309,1,2,0)
 ;;=2^90732
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Pneumovax 23 (Pneumococcal Vaccine)
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=90715^^4^25^20^^^^1
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,310,1,2,0)
 ;;=2^90715
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^TDaP Vaccine
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=90736^^4^25^22^^^^1
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,311,1,2,0)
 ;;=2^90736
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Zoster (Shingles) Vaccine-Subcu
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=90672^^4^25^2^^^^1
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,312,1,2,0)
 ;;=2^90672
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Flu Vaccine Intranasal,Quadrivalent,Live
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=90714^^4^25^19^^^^1
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,313,1,2,0)
 ;;=2^90714
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^TD Vaccine
 ;;^UTILITY(U,$J,358.3,314,0)
 ;;=90739^^4^25^10^^^^1
 ;;^UTILITY(U,$J,358.3,314,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,314,1,2,0)
 ;;=2^90739
 ;;^UTILITY(U,$J,358.3,314,1,3,0)
 ;;=3^Hep B,Adult Dose (2 dose schedule)
 ;;^UTILITY(U,$J,358.3,315,0)
 ;;=90670^^4^25^18^^^^1
 ;;^UTILITY(U,$J,358.3,315,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,315,1,2,0)
 ;;=2^90670
 ;;^UTILITY(U,$J,358.3,315,1,3,0)
 ;;=3^Prevnar 13 (Pneumococcal Vaccine)
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=90686^^4^25^8^^^^1
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,316,1,2,0)
 ;;=2^90686
 ;;^UTILITY(U,$J,358.3,316,1,3,0)
 ;;=3^Flu Vaccine Sgl Dose Syr (Fluarix Quadrivalent)
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=90664^^4^25^1^^^^1
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,317,1,2,0)
 ;;=2^90664
 ;;^UTILITY(U,$J,358.3,317,1,3,0)
 ;;=3^Flu Vaccine Intranasal,Pandemic,Live
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=90674^^4^25^3^^^^1
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,318,1,2,0)
 ;;=2^90674
 ;;^UTILITY(U,$J,358.3,318,1,3,0)
 ;;=3^Flu Vaccine Low Dose Syr (Flucelvax CCIIV4)
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=90656^^4^25^6^^^^1
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,319,1,2,0)
 ;;=2^90656
 ;;^UTILITY(U,$J,358.3,319,1,3,0)
 ;;=3^Flu Vaccine Sgl Dose Syr (Aflurial IV)
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=90688^^4^25^5^^^^1
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,320,1,2,0)
 ;;=2^90688
 ;;^UTILITY(U,$J,358.3,320,1,3,0)
 ;;=3^Flu Vaccine Multi Dose Vial (Flulaval Quadrivalent)
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=90682^^4^25^9^^^^1
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,321,1,2,0)
 ;;=2^90682
 ;;^UTILITY(U,$J,358.3,321,1,3,0)
 ;;=3^Flu Vaccine Sgl Dose Syr FLUBLOK (RIV4)
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=90750^^4^25^21^^^^1
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,322,1,2,0)
 ;;=2^90750
 ;;^UTILITY(U,$J,358.3,322,1,3,0)
 ;;=3^Zoster (Shingles) Vaccine-IM
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=90653^^4^25^7^^^^1
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,323,1,2,0)
 ;;=2^90653
 ;;^UTILITY(U,$J,358.3,323,1,3,0)
 ;;=3^Flu Vaccine Sgl Dose Syr (Fluad Sequirus)
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=90671^^4^25^15^^^^1
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,324,1,2,0)
 ;;=2^90671
 ;;^UTILITY(U,$J,358.3,324,1,3,0)
 ;;=3^Pneumococcal Conjugate;15 Valent (PCV15)
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=90677^^4^25^16^^^^1
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,325,1,2,0)
 ;;=2^90677
 ;;^UTILITY(U,$J,358.3,325,1,3,0)
 ;;=3^Pneumococcal Conjugate;20 Valent (PCV20)
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=99406^^4^26^1^^^^1
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,326,1,2,0)
 ;;=2^99406
 ;;^UTILITY(U,$J,358.3,326,1,3,0)
 ;;=3^Tobacco Use Cessation,Intermediate 3-10 min
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=99407^^4^26^2^^^^1
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,327,1,2,0)
 ;;=2^99407
 ;;^UTILITY(U,$J,358.3,327,1,3,0)
 ;;=3^Tobacco Use Cessation,Intensive > 10 min
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=99408^^4^26^3^^^^1
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,328,1,2,0)
 ;;=2^99408
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Alcohol/Subs Abuse Scrn/Intervention 15-30 min
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=99409^^4^26^4^^^^1
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,329,1,2,0)
 ;;=2^99409
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Alcohol/Subs Abuse Scrn/Intervention > 30 min
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=99401^^4^27^1^^^^1
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,330,1,2,0)
 ;;=2^99401
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Brief Counseling,15 Min
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=99402^^4^27^2^^^^1
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,331,1,2,0)
 ;;=2^99402
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Intermediate Counseling,30 Min
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=99403^^4^27^3^^^^1
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,332,1,2,0)
 ;;=2^99403
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Extended Counseling,45 Min
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=99404^^4^27^4^^^^1
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,333,1,2,0)
 ;;=2^99404
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^Comprehensive Counseling,60 Min
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=96160^^4^28^2^^^^1
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,334,1,2,0)
 ;;=2^96160
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^Admin/Intrp Hlth Risk Assess,Patient-Focused
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=96161^^4^28^1^^^^1
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,335,1,2,0)
 ;;=2^96161
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^Admin/Intrp Hlth Risk Assess,Caregiver-Focused
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=99411^^4^29^1^^^^1
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,336,1,2,0)
 ;;=2^99411
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^Brief Counseling,Grp,30 Min
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=99412^^4^29^2^^^^1
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,337,1,2,0)
 ;;=2^99412
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^Intermediate Counseling,Grp,60 Min
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=99395^^4^30^1^^^^1
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,338,1,2,0)
 ;;=2^99395
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Preventive Hlth Visit,Est Pt 18-39
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=99396^^4^30^2^^^^1
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,339,1,2,0)
 ;;=2^99396
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Preventive Hlth Visit,Est Pt 40-64
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=99397^^4^30^3^^^^1
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,340,1,2,0)
 ;;=2^99397
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Preventive Hlth Visit,Est Pt > 64
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=99385^^4^31^1^^^^1
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,341,1,2,0)
 ;;=2^99385
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Preventive Hlth Visit,New Pt 18-39
 ;;^UTILITY(U,$J,358.3,342,0)
 ;;=99386^^4^31^2^^^^1
 ;;^UTILITY(U,$J,358.3,342,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,342,1,2,0)
 ;;=2^99386
 ;;^UTILITY(U,$J,358.3,342,1,3,0)
 ;;=3^Preventive Hlth Visit,New Pt 40-64
 ;;^UTILITY(U,$J,358.3,343,0)
 ;;=99387^^4^31^3^^^^1
 ;;^UTILITY(U,$J,358.3,343,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,343,1,2,0)
 ;;=2^99387
 ;;^UTILITY(U,$J,358.3,343,1,3,0)
 ;;=3^Preventive Hlth Visit,New Pt > 64
 ;;^UTILITY(U,$J,358.3,344,0)
 ;;=90471^^4^32^1^^^^1
 ;;^UTILITY(U,$J,358.3,344,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,344,1,2,0)
 ;;=2^90471
 ;;^UTILITY(U,$J,358.3,344,1,3,0)
 ;;=3^Immunization Admin,1 Vaccine
 ;;^UTILITY(U,$J,358.3,345,0)
 ;;=90472^^4^32^2^^^^1
 ;;^UTILITY(U,$J,358.3,345,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,345,1,2,0)
 ;;=2^90472
 ;;^UTILITY(U,$J,358.3,345,1,3,0)
 ;;=3^Immunization Admin,Ea Addl Vaccine
 ;;^UTILITY(U,$J,358.3,346,0)
 ;;=31502^^5^33^1^^^^1
 ;;^UTILITY(U,$J,358.3,346,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,346,1,1,0)
 ;;=1^31502
 ;;^UTILITY(U,$J,358.3,346,1,3,0)
 ;;=3^Trach Change
 ;;^UTILITY(U,$J,358.3,347,0)
 ;;=95805^^5^34^2^^^^1
 ;;^UTILITY(U,$J,358.3,347,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,347,1,1,0)
 ;;=1^95805
 ;;^UTILITY(U,$J,358.3,347,1,3,0)
 ;;=3^Maintenance of Wakefulness Test (MWT)
 ;;^UTILITY(U,$J,358.3,348,0)
 ;;=95810^^5^34^3^^^^1
 ;;^UTILITY(U,$J,358.3,348,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,348,1,1,0)
 ;;=1^95810
 ;;^UTILITY(U,$J,358.3,348,1,3,0)
 ;;=3^PSG 4+ Parameters
 ;;^UTILITY(U,$J,358.3,349,0)
 ;;=95811^^5^34^4^^^^1
 ;;^UTILITY(U,$J,358.3,349,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,349,1,1,0)
 ;;=1^95811
 ;;^UTILITY(U,$J,358.3,349,1,3,0)
 ;;=3^PSG 4+ Parameters Split w/ or w/o PAP
 ;;^UTILITY(U,$J,358.3,350,0)
 ;;=95803^^5^34^1^^^^1
 ;;^UTILITY(U,$J,358.3,350,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,350,1,1,0)
 ;;=1^95803
 ;;^UTILITY(U,$J,358.3,350,1,3,0)
 ;;=3^Actigraphy Test;72 hr-14 Days
 ;;^UTILITY(U,$J,358.3,351,0)
 ;;=95807^^5^34^6^^^^1
 ;;^UTILITY(U,$J,358.3,351,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,351,1,1,0)
 ;;=1^95807
 ;;^UTILITY(U,$J,358.3,351,1,3,0)
 ;;=3^Sleep Study,Attended by Tech,No EEG
 ;;^UTILITY(U,$J,358.3,352,0)
 ;;=95808^^5^34^5^^^^1
 ;;^UTILITY(U,$J,358.3,352,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,352,1,1,0)
 ;;=1^95808
 ;;^UTILITY(U,$J,358.3,352,1,3,0)
 ;;=3^Polysomnography,Attended by Tech
 ;;^UTILITY(U,$J,358.3,353,0)
 ;;=94762^^5^35^1^^^^1
 ;;^UTILITY(U,$J,358.3,353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,353,1,1,0)
 ;;=1^94762
 ;;^UTILITY(U,$J,358.3,353,1,3,0)
 ;;=3^Oximetry Overnight
 ;;^UTILITY(U,$J,358.3,354,0)
 ;;=94660^^5^36^1^^^^1
 ;;^UTILITY(U,$J,358.3,354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,354,1,1,0)
 ;;=1^94660
 ;;^UTILITY(U,$J,358.3,354,1,3,0)
 ;;=3^CPAP Set Up/Management
 ;;^UTILITY(U,$J,358.3,355,0)
 ;;=99070^^5^36^2^^^^1
 ;;^UTILITY(U,$J,358.3,355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,355,1,1,0)
 ;;=1^99070
 ;;^UTILITY(U,$J,358.3,355,1,3,0)
 ;;=3^Supplies/Materials
 ;;^UTILITY(U,$J,358.3,356,0)
 ;;=98960^^5^37^3^^^^1
 ;;^UTILITY(U,$J,358.3,356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,356,1,1,0)
 ;;=1^98960
 ;;^UTILITY(U,$J,358.3,356,1,3,0)
 ;;=3^Educ/Train Ind,Ea 30 min
 ;;^UTILITY(U,$J,358.3,357,0)
 ;;=98961^^5^37^1^^^^1
 ;;^UTILITY(U,$J,358.3,357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,357,1,1,0)
 ;;=1^98961
 ;;^UTILITY(U,$J,358.3,357,1,3,0)
 ;;=3^Educ/Train Grp,2-4 Pts,Ea 30 min
 ;;^UTILITY(U,$J,358.3,358,0)
 ;;=98962^^5^37^2^^^^1
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,358,1,1,0)
 ;;=1^98962
 ;;^UTILITY(U,$J,358.3,358,1,3,0)
 ;;=3^Educ/Train Grp,5-8 Pts,Ea 30 min
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=99071^^5^37^4^^^^1
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,359,1,1,0)
 ;;=1^99071
 ;;^UTILITY(U,$J,358.3,359,1,3,0)
 ;;=3^Education Materials
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=99417^^5^38^1^^^^1
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,360,1,1,0)
 ;;=1^99417
 ;;^UTILITY(U,$J,358.3,360,1,3,0)
 ;;=3^Prolng Off/Outpt E/M Svc,Ea 15 min (Use with 99205/99215)
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=95800^^5^39^1^^^^1
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,361,1,1,0)
 ;;=1^95800
 ;;^UTILITY(U,$J,358.3,361,1,3,0)
 ;;=3^Slp Stdy Unatnd w/ Min Hrt Rate/O2 Sat/Slp Time
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=95806^^5^39^3^^^^1
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,362,1,1,0)
 ;;=1^95806
 ;;^UTILITY(U,$J,358.3,362,1,3,0)
 ;;=3^Slp Stdy Unatnd w/ Resp Effort
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=95801^^5^39^2^^^^1
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,363,1,1,0)
 ;;=1^95801
 ;;^UTILITY(U,$J,358.3,363,1,3,0)
 ;;=3^Slp Stdy Unatnd w/ Min Hrt Rate/O2 Sat/Resp Analysis
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=Q3014^^5^40^1^^^^1
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,364,1,1,0)
 ;;=1^Q3014
 ;;^UTILITY(U,$J,358.3,364,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=99091^^5^41^1^^^^1
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,365,1,1,0)
 ;;=1^99091
 ;;^UTILITY(U,$J,358.3,365,1,3,0)
 ;;=3^LIP Review PAP Data w/o Pt Communication
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=99454^^5^41^4^^^^1
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,366,1,1,0)
 ;;=1^99454
 ;;^UTILITY(U,$J,358.3,366,1,3,0)
 ;;=3^Remote Monitor Device Record/Prg Alert
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=99457^^5^41^2^^^^1
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,367,1,1,0)
 ;;=1^99457
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^PAP Data Review w/ Pt Communication,1st 20 min
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=99458^^5^41^3^^^^1
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,368,1,1,0)
 ;;=1^99458
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^PAP Data Review w/ Pt Communication,Ea Addl 20 min
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=99202^^6^42^1
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,369,1,1,0)
 ;;=1^SF MDM or 15-29 mins
 ;;^UTILITY(U,$J,358.3,369,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=99203^^6^42^2
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,370,1,1,0)
 ;;=1^Low Complex MDM or 30-44 mins
