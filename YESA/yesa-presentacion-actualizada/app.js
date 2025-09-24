class PresentationApp {
    constructor() {
        this.currentSlide = 1;
        this.totalSlides = 11; // Updated to 11 slides
        this.slides = document.querySelectorAll('.slide');
        this.prevBtn = document.getElementById('prevBtn');
        this.nextBtn = document.getElementById('nextBtn');
        this.currentSlideSpan = document.getElementById('currentSlide');
        this.totalSlidesSpan = document.getElementById('totalSlides');
        
        this.init();
    }

    init() {
        // Ensure elements exist before proceeding
        if (!this.prevBtn || !this.nextBtn || !this.currentSlideSpan || !this.totalSlidesSpan) {
            console.error('Navigation elements not found');
            return;
        }

        // Set initial state
        this.updateSlideDisplay();
        this.updateCounter();
        this.updateNavigationButtons();

        // Remove any existing event listeners and add new ones
        this.prevBtn.replaceWith(this.prevBtn.cloneNode(true));
        this.nextBtn.replaceWith(this.nextBtn.cloneNode(true));
        
        // Get fresh references
        this.prevBtn = document.getElementById('prevBtn');
        this.nextBtn = document.getElementById('nextBtn');

        // Add event listeners with proper binding
        this.prevBtn.addEventListener('click', (event) => {
            console.log('Previous button clicked');
            event.preventDefault();
            event.stopPropagation();
            this.previousSlide();
        }, true);
        
        this.nextBtn.addEventListener('click', (event) => {
            console.log('Next button clicked');
            event.preventDefault();
            event.stopPropagation();
            this.nextSlide();
        }, true);

        // Also add direct onclick handlers as backup
        this.prevBtn.onclick = (event) => {
            console.log('Previous button onclick');
            event.preventDefault();
            this.previousSlide();
            return false;
        };
        
        this.nextBtn.onclick = (event) => {
            console.log('Next button onclick');
            event.preventDefault();
            this.nextSlide();
            return false;
        };
        
        // Keyboard navigation
        document.addEventListener('keydown', (event) => this.handleKeydown(event));
        
        // Touch/swipe support for mobile
        this.addTouchSupport();

        console.log('Presentation initialized successfully with 11 slides');
    }

    goToSlide(slideNumber) {
        if (slideNumber < 1 || slideNumber > this.totalSlides) {
            return;
        }

        console.log(`Navigating to slide ${slideNumber}`);

        // Remove active class from all slides
        this.slides.forEach(slide => {
            slide.classList.remove('active', 'prev');
        });

        // Add active class to target slide
        const targetSlide = document.querySelector(`[data-slide="${slideNumber}"]`);
        if (targetSlide) {
            targetSlide.classList.add('active');
        }

        this.currentSlide = slideNumber;
        this.updateCounter();
        this.updateNavigationButtons();
    }

    nextSlide() {
        console.log('Next slide method called');
        if (this.currentSlide < this.totalSlides) {
            this.goToSlide(this.currentSlide + 1);
        }
    }

    previousSlide() {
        console.log('Previous slide method called');
        if (this.currentSlide > 1) {
            this.goToSlide(this.currentSlide - 1);
        }
    }

    updateSlideDisplay() {
        this.slides.forEach((slide, index) => {
            slide.classList.remove('active', 'prev');
            if (index + 1 === this.currentSlide) {
                slide.classList.add('active');
            }
        });
    }

    updateCounter() {
        if (this.currentSlideSpan && this.totalSlidesSpan) {
            this.currentSlideSpan.textContent = this.currentSlide;
            this.totalSlidesSpan.textContent = this.totalSlides;
        }
    }

    updateNavigationButtons() {
        if (!this.prevBtn || !this.nextBtn) return;

        // Update previous button
        if (this.currentSlide <= 1) {
            this.prevBtn.disabled = true;
            this.prevBtn.setAttribute('aria-disabled', 'true');
        } else {
            this.prevBtn.disabled = false;
            this.prevBtn.setAttribute('aria-disabled', 'false');
        }

        // Update next button
        if (this.currentSlide >= this.totalSlides) {
            this.nextBtn.disabled = true;
            this.nextBtn.setAttribute('aria-disabled', 'true');
        } else {
            this.nextBtn.disabled = false;
            this.nextBtn.setAttribute('aria-disabled', 'false');
        }
    }

    handleKeydown(event) {
        switch(event.key) {
            case 'ArrowRight':
            case ' ': // Spacebar
                event.preventDefault();
                this.nextSlide();
                break;
            case 'ArrowLeft':
                event.preventDefault();
                this.previousSlide();
                break;
            case 'Home':
                event.preventDefault();
                this.goToSlide(1);
                break;
            case 'End':
                event.preventDefault();
                this.goToSlide(this.totalSlides);
                break;
            case 'Escape':
                event.preventDefault();
                this.goToSlide(1);
                break;
            // Number keys for direct navigation
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                event.preventDefault();
                this.goToSlide(parseInt(event.key));
                break;
        }
    }

    addTouchSupport() {
        let startX = 0;
        let startY = 0;
        let endX = 0;
        let endY = 0;
        const minSwipeDistance = 50;

        const presentationContainer = document.querySelector('.presentation-container');
        if (!presentationContainer) return;

        presentationContainer.addEventListener('touchstart', (event) => {
            startX = event.touches[0].clientX;
            startY = event.touches[0].clientY;
        }, { passive: true });

        presentationContainer.addEventListener('touchmove', (event) => {
            event.preventDefault(); // Prevent scrolling
        }, { passive: false });

        presentationContainer.addEventListener('touchend', (event) => {
            endX = event.changedTouches[0].clientX;
            endY = event.changedTouches[0].clientY;

            const deltaX = endX - startX;
            const deltaY = endY - startY;

            // Check if horizontal swipe is greater than vertical swipe
            if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > minSwipeDistance) {
                if (deltaX > 0) {
                    // Swipe right - go to previous slide
                    this.previousSlide();
                } else {
                    // Swipe left - go to next slide
                    this.nextSlide();
                }
            }
        }, { passive: true });
    }

    // Method to programmatically navigate to specific slide
    navigateToSlide(slideNumber) {
        this.goToSlide(slideNumber);
    }

    // Method to get current slide info
    getCurrentSlideInfo() {
        return {
            current: this.currentSlide,
            total: this.totalSlides,
            isFirst: this.currentSlide === 1,
            isLast: this.currentSlide === this.totalSlides
        };
    }

    // Method to start auto-play (optional feature)
    startAutoPlay(intervalSeconds = 10) {
        this.stopAutoPlay(); // Clear any existing interval
        this.autoPlayInterval = setInterval(() => {
            if (this.currentSlide < this.totalSlides) {
                this.nextSlide();
            } else {
                this.goToSlide(1); // Loop back to first slide
            }
        }, intervalSeconds * 1000);
        console.log(`Auto-play started with ${intervalSeconds}s interval`);
    }

    // Method to stop auto-play
    stopAutoPlay() {
        if (this.autoPlayInterval) {
            clearInterval(this.autoPlayInterval);
            this.autoPlayInterval = null;
            console.log('Auto-play stopped');
        }
    }

    // Method to toggle fullscreen
    toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(err => {
                console.log(`Error attempting to enable fullscreen: ${err.message}`);
            });
        } else {
            document.exitFullscreen();
        }
    }
}

// Global navigation functions that can be called directly
function goToNextSlide() {
    console.log('Global next slide function called');
    if (window.presentation) {
        window.presentation.nextSlide();
    }
}

function goToPrevSlide() {
    console.log('Global previous slide function called');
    if (window.presentation) {
        window.presentation.previousSlide();
    }
}

// Initialize the presentation when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    console.log('DOM loaded, initializing presentation...');
    
    // Wait a bit to ensure all elements are rendered
    setTimeout(() => {
        const presentation = new PresentationApp();
        
        // Make presentation globally available
        window.presentation = presentation;
        
        // Add multiple backup click handlers
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        
        if (prevBtn) {
            // Multiple event handlers for reliability
            prevBtn.addEventListener('mousedown', (e) => {
                console.log('Previous mousedown');
                e.preventDefault();
                presentation.previousSlide();
            });
            
            prevBtn.addEventListener('touchstart', (e) => {
                console.log('Previous touchstart');
                e.preventDefault();
                presentation.previousSlide();
            });
        }
        
        if (nextBtn) {
            // Multiple event handlers for reliability
            nextBtn.addEventListener('mousedown', (e) => {
                console.log('Next mousedown');
                e.preventDefault();
                presentation.nextSlide();
            });
            
            nextBtn.addEventListener('touchstart', (e) => {
                console.log('Next touchstart');
                e.preventDefault();
                presentation.nextSlide();
            });
        }
        
        console.log('Presentation fully initialized with 11 slides');
        
        // Test button functionality
        setTimeout(() => {
            console.log('Button elements:', { prevBtn, nextBtn });
            console.log('Button event listeners should be working now');
        }, 500);
    }, 100);
});

// Handle fullscreen functionality
document.addEventListener('keydown', (event) => {
    if (event.key === 'F11' || (event.key === 'f' && event.ctrlKey)) {
        event.preventDefault();
        if (window.presentation) {
            window.presentation.toggleFullscreen();
        }
    }
    
    // Add 'p' key for presentation mode (fullscreen)
    if (event.key === 'p' || event.key === 'P') {
        event.preventDefault();
        if (window.presentation) {
            window.presentation.toggleFullscreen();
        }
    }
});

// Handle visibility change
document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
        console.log('Presentation paused (tab not visible)');
        if (window.presentation) {
            window.presentation.stopAutoPlay();
        }
    } else {
        console.log('Presentation resumed');
    }
});

// Handle window resize
window.addEventListener('resize', () => {
    const activeSlide = document.querySelector('.slide.active');
    if (activeSlide) {
        // Force reflow to handle responsive changes
        activeSlide.style.display = 'none';
        activeSlide.offsetHeight; // Trigger reflow
        activeSlide.style.display = 'flex';
    }
});

// Add some helpful console commands for development/presentation
window.addEventListener('load', () => {
    console.log('=== YESA Presentation Controls ===');
    console.log('Use arrow keys or space to navigate');
    console.log('Press P for fullscreen mode');
    console.log('Press numbers 1-9 for direct slide navigation');
    console.log('Console commands:');
    console.log('  presentation.goToSlide(n) - Go to slide n');
    console.log('  presentation.startAutoPlay(seconds) - Start auto-play');
    console.log('  presentation.stopAutoPlay() - Stop auto-play');
    console.log('  presentation.toggleFullscreen() - Toggle fullscreen');
    console.log('=====================================');
});

// Export for module use
if (typeof module !== 'undefined' && module.exports) {
    module.exports = PresentationApp;
}