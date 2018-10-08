;---------------------------------------------------------------------------------------------------------
; This .ctl file is to calculate dispersion curve of photonic crystal (PhC) waveguide using 3D simulation.
; The PhC slab is composed of air holes with triangular lattice in silicon.                               
; The PhC waveguide is formed by removing one row of air holes (W1.00).                                   
; Written by Yuyang ZHUANG.                                                                               
; Tanabe Lab at Keio University.                                                                          
; 2018/10/5.                                                                                              
;---------------------------------------------------------------------------------------------------------

; Define global variables.
(define a 420) ; lattice constant 420 nm
(define r (/ 120 a)) ; radius of air hole 120 nm
(define t (/ 210 a)) ; thickness of PhC slab 210 nm
(define eps1 (expt 3.47 2)) ; epsilon of silicon (Si) at 1550 nm
(define eps2 (expt 1 2)) ; epsilon of air 

; Step 1: Set calculating band numbers.
(set! num-bands 20)

; Step 2: Set geometry of super-cell.
(set! geometry-lattice (make lattice (size 1 11 2) ; super-cell size is 1*11*2.
                         (basis1 (/ (sqrt 3) 2) 0.5)
                         (basis2 (/ (sqrt 3) 2) -0.5)
		          (basis3 0 0 1)
))

; Step 3: Set k-points.
(define Gamma (vector3 0 0 0))
(define K' (vector3 0.5 0 0)) ; edge of Brillouin zone.
(set! k-points (interpolate 4 (list Gamma K'))) ; interpolate k-points, time-consuming with a large number.

; Step 4.1: Set background index.
(set! default-material air)

; Step 4.2: Set geometry of the PhC waveguide. 
(set! geometry (list  
	; Si slab.
		(make block (center 0 0 0) (size infinity infinity t) (material (make dielectric (epsilon eps1))))
	; Air holes.
		(make cylinder 
			(center 0 1 0) (radius r)   (height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 2 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 3 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 4 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 5 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 6 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center 0 7 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center 0 -1 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 -2 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 -3 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 -4 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 -5 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))	
		(make cylinder 
			(center 0 -6 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
		(make cylinder 
			(center 0 -7 0) (radius r)	(height t)   (material (make dielectric (epsilon eps2))))
))

; Step 5: Set resolution.
(set! resolution 16)

; Step 6: Run even(odd) mode.
(run-zeven)
;(run-zodd)
