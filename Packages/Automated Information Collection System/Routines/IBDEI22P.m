IBDEI22P ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34760,1,4,0)
 ;;=4^D35.2
 ;;^UTILITY(U,$J,358.3,34760,2)
 ;;=^5002145
 ;;^UTILITY(U,$J,358.3,34761,0)
 ;;=C75.1^^160^1769^19
 ;;^UTILITY(U,$J,358.3,34761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34761,1,3,0)
 ;;=3^Malignant neoplasm of pituitary gland
 ;;^UTILITY(U,$J,358.3,34761,1,4,0)
 ;;=4^C75.1
 ;;^UTILITY(U,$J,358.3,34761,2)
 ;;=^5001320
 ;;^UTILITY(U,$J,358.3,34762,0)
 ;;=C71.1^^160^1769^12
 ;;^UTILITY(U,$J,358.3,34762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34762,1,3,0)
 ;;=3^Malignant neoplasm of frontal lobe
 ;;^UTILITY(U,$J,358.3,34762,1,4,0)
 ;;=4^C71.1
 ;;^UTILITY(U,$J,358.3,34762,2)
 ;;=^267281
 ;;^UTILITY(U,$J,358.3,34763,0)
 ;;=C71.2^^160^1769^25
 ;;^UTILITY(U,$J,358.3,34763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34763,1,3,0)
 ;;=3^Malignant neoplasm of temporal lobe
 ;;^UTILITY(U,$J,358.3,34763,1,4,0)
 ;;=4^C71.2
 ;;^UTILITY(U,$J,358.3,34763,2)
 ;;=^267282
 ;;^UTILITY(U,$J,358.3,34764,0)
 ;;=C71.3^^160^1769^18
 ;;^UTILITY(U,$J,358.3,34764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34764,1,3,0)
 ;;=3^Malignant neoplasm of parietal lobe
 ;;^UTILITY(U,$J,358.3,34764,1,4,0)
 ;;=4^C71.3
 ;;^UTILITY(U,$J,358.3,34764,2)
 ;;=^267283
 ;;^UTILITY(U,$J,358.3,34765,0)
 ;;=C71.4^^160^1769^16
 ;;^UTILITY(U,$J,358.3,34765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34765,1,3,0)
 ;;=3^Malignant neoplasm of occipital lobe
 ;;^UTILITY(U,$J,358.3,34765,1,4,0)
 ;;=4^C71.4
 ;;^UTILITY(U,$J,358.3,34765,2)
 ;;=^267284
 ;;^UTILITY(U,$J,358.3,34766,0)
 ;;=C71.5^^160^1769^11
 ;;^UTILITY(U,$J,358.3,34766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34766,1,3,0)
 ;;=3^Malignant neoplasm of cerebral ventricle
 ;;^UTILITY(U,$J,358.3,34766,1,4,0)
 ;;=4^C71.5
 ;;^UTILITY(U,$J,358.3,34766,2)
 ;;=^5001294
 ;;^UTILITY(U,$J,358.3,34767,0)
 ;;=C71.6^^160^1769^9
 ;;^UTILITY(U,$J,358.3,34767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34767,1,3,0)
 ;;=3^Malignant neoplasm of cerebellum
 ;;^UTILITY(U,$J,358.3,34767,1,4,0)
 ;;=4^C71.6
 ;;^UTILITY(U,$J,358.3,34767,2)
 ;;=^5001295
 ;;^UTILITY(U,$J,358.3,34768,0)
 ;;=C71.7^^160^1769^5
 ;;^UTILITY(U,$J,358.3,34768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34768,1,3,0)
 ;;=3^Malignant neoplasm of brain stem
 ;;^UTILITY(U,$J,358.3,34768,1,4,0)
 ;;=4^C71.7
 ;;^UTILITY(U,$J,358.3,34768,2)
 ;;=^267287
 ;;^UTILITY(U,$J,358.3,34769,0)
 ;;=C72.0^^160^1769^23
 ;;^UTILITY(U,$J,358.3,34769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34769,1,3,0)
 ;;=3^Malignant neoplasm of spinal cord
 ;;^UTILITY(U,$J,358.3,34769,1,4,0)
 ;;=4^C72.0
 ;;^UTILITY(U,$J,358.3,34769,2)
 ;;=^267292
 ;;^UTILITY(U,$J,358.3,34770,0)
 ;;=C72.1^^160^1769^7
 ;;^UTILITY(U,$J,358.3,34770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34770,1,3,0)
 ;;=3^Malignant neoplasm of cauda equina
 ;;^UTILITY(U,$J,358.3,34770,1,4,0)
 ;;=4^C72.1
 ;;^UTILITY(U,$J,358.3,34770,2)
 ;;=^5001298
 ;;^UTILITY(U,$J,358.3,34771,0)
 ;;=C72.21^^160^1769^21
 ;;^UTILITY(U,$J,358.3,34771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34771,1,3,0)
 ;;=3^Malignant neoplasm of right olfactory nerve
 ;;^UTILITY(U,$J,358.3,34771,1,4,0)
 ;;=4^C72.21
 ;;^UTILITY(U,$J,358.3,34771,2)
 ;;=^5001300
 ;;^UTILITY(U,$J,358.3,34772,0)
 ;;=C72.22^^160^1769^14
 ;;^UTILITY(U,$J,358.3,34772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34772,1,3,0)
 ;;=3^Malignant neoplasm of left olfactory nerve
 ;;^UTILITY(U,$J,358.3,34772,1,4,0)
 ;;=4^C72.22
 ;;^UTILITY(U,$J,358.3,34772,2)
 ;;=^5001301
 ;;^UTILITY(U,$J,358.3,34773,0)
 ;;=C72.31^^160^1769^22
 ;;^UTILITY(U,$J,358.3,34773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34773,1,3,0)
 ;;=3^Malignant neoplasm of right optic nerve
