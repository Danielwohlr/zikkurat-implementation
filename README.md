# Custom RNG implementation using Zikkurat method in MATLAB 

This report presents the implementation of the Ziggurat method for generating pseudorandom numbers using MATLAB. It extends the method to both Normal (Gaussian) and Generalized Inverse Gaussian (GIG) distributions, exploring algorithmic adaptations for these specific cases. The GIG distribution is of the form
$$f(x) = \frac{(\frac{a}{b})^{p/2}}{2 \mathcal{K}_p(\sqrt{ab})} \Theta(x) x^{p-1} \mathrm{exp}\left(-\frac{ax +\frac{b}{x}}{2}\right),$$

where $\Theta(x)$ is the Heaviside step function, $\mathcal{K}_p$ is the modified Bessel function of the second kind, and the parameters are $a,b>0, p \in \mathbb{R}$.

The final report is in ```english-version.pdf```. 

![Project Screenshot](images/drawing_ziggurat.svg "Implementation of Zikkurat method")
![Project Screenshot](images/zikkurat.jpeg "Zikkurat building")

## Table of Contents
- [GAUSS](#gauss)
- [GIG](#gig)
- [Images](#images)

## GAUSS

Contains MATLAB scripts for the Zikkurat algorithm (rejection rules, statistical checks, fallback, etc.) implementation in the case of the Normal (Gaussian) distribution.

## GIG

Contains MATLAB scripts for the Zikkurat algorithm (rejection rules, statistical checks, fallback, etc.) implementation in the case of the GIG distribution.

## Images

All the generated images are saved in the directory ```images```. It is usually not a good practice to upload images to github.
