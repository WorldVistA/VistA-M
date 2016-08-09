IBDEI07I ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7424,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,7424,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,7424,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,7425,0)
 ;;=I34.1^^42^497^14
 ;;^UTILITY(U,$J,358.3,7425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7425,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,7425,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,7425,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,7426,0)
 ;;=D68.4^^42^498^1
 ;;^UTILITY(U,$J,358.3,7426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7426,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,7426,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,7426,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,7427,0)
 ;;=D59.9^^42^498^2
 ;;^UTILITY(U,$J,358.3,7427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7427,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,7427,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,7427,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,7428,0)
 ;;=C91.00^^42^498^5
 ;;^UTILITY(U,$J,358.3,7428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7428,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,7428,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,7428,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,7429,0)
 ;;=C91.01^^42^498^4
 ;;^UTILITY(U,$J,358.3,7429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7429,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,7429,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,7429,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,7430,0)
 ;;=C92.01^^42^498^7
 ;;^UTILITY(U,$J,358.3,7430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7430,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,7430,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,7430,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,7431,0)
 ;;=C92.00^^42^498^8
 ;;^UTILITY(U,$J,358.3,7431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7431,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,7431,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,7431,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,7432,0)
 ;;=C92.61^^42^498^9
 ;;^UTILITY(U,$J,358.3,7432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7432,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,7432,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,7432,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,7433,0)
 ;;=C92.60^^42^498^10
 ;;^UTILITY(U,$J,358.3,7433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7433,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,7433,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,7433,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,7434,0)
 ;;=C92.A1^^42^498^11
 ;;^UTILITY(U,$J,358.3,7434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7434,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,7434,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,7434,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,7435,0)
 ;;=C92.A0^^42^498^12
 ;;^UTILITY(U,$J,358.3,7435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7435,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,7435,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,7435,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,7436,0)
 ;;=C92.51^^42^498^13
 ;;^UTILITY(U,$J,358.3,7436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7436,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,7436,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,7436,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,7437,0)
 ;;=C92.50^^42^498^14
 ;;^UTILITY(U,$J,358.3,7437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7437,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,7437,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,7437,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,7438,0)
 ;;=C94.40^^42^498^17
 ;;^UTILITY(U,$J,358.3,7438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7438,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,7438,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,7438,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,7439,0)
 ;;=C94.42^^42^498^15
 ;;^UTILITY(U,$J,358.3,7439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7439,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,7439,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,7439,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,7440,0)
 ;;=C94.41^^42^498^16
 ;;^UTILITY(U,$J,358.3,7440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7440,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,7440,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,7440,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,7441,0)
 ;;=D62.^^42^498^18
 ;;^UTILITY(U,$J,358.3,7441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7441,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,7441,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,7441,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,7442,0)
 ;;=C92.41^^42^498^19
 ;;^UTILITY(U,$J,358.3,7442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7442,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,7442,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,7442,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,7443,0)
 ;;=C92.40^^42^498^20
 ;;^UTILITY(U,$J,358.3,7443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7443,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,7443,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,7443,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,7444,0)
 ;;=D56.0^^42^498^21
 ;;^UTILITY(U,$J,358.3,7444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7444,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,7444,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,7444,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,7445,0)
 ;;=D63.1^^42^498^23
 ;;^UTILITY(U,$J,358.3,7445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7445,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,7445,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,7445,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,7446,0)
 ;;=D63.0^^42^498^24
 ;;^UTILITY(U,$J,358.3,7446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7446,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,7446,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,7446,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,7447,0)
 ;;=D63.8^^42^498^22
 ;;^UTILITY(U,$J,358.3,7447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7447,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,7447,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,7447,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,7448,0)
 ;;=C22.3^^42^498^25
 ;;^UTILITY(U,$J,358.3,7448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7448,1,3,0)
 ;;=3^Angiosarcoma of Liver
 ;;^UTILITY(U,$J,358.3,7448,1,4,0)
 ;;=4^C22.3
 ;;^UTILITY(U,$J,358.3,7448,2)
 ;;=^5000936
 ;;^UTILITY(U,$J,358.3,7449,0)
 ;;=D61.9^^42^498^26
 ;;^UTILITY(U,$J,358.3,7449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7449,1,3,0)
 ;;=3^Aplastic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,7449,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,7449,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,7450,0)
 ;;=D56.1^^42^498^28
 ;;^UTILITY(U,$J,358.3,7450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7450,1,3,0)
 ;;=3^Beta Thalassemia
 ;;^UTILITY(U,$J,358.3,7450,1,4,0)
 ;;=4^D56.1
 ;;^UTILITY(U,$J,358.3,7450,2)
 ;;=^340495
 ;;^UTILITY(U,$J,358.3,7451,0)
 ;;=C83.79^^42^498^29
 ;;^UTILITY(U,$J,358.3,7451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7451,1,3,0)
 ;;=3^Burkitt Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,7451,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,7451,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,7452,0)
 ;;=C83.70^^42^498^30
