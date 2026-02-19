document.addEventListener('DOMContentLoaded', () => {
    const startScreen = document.getElementById('start-screen');
    const formScreen = document.getElementById('form-screen');
    const loadingScreen = document.getElementById('loading-screen');
    const resultsScreen = document.getElementById('results-screen');
    const startBtn = document.getElementById('start-btn');
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const submitBtn = document.getElementById('submit-btn');
    const resetBtn = document.getElementById('reset-btn');
    const formStepsContainer = document.getElementById('form-steps');
    const progressFill = document.getElementById('progress-fill');
    const stepIndicator = document.getElementById('step-indicator');

    let currentStep = 0;
    const questions = [
        // Step 1: Demographics
        {
            title: "Demographics",
            questions: [
                { id: "Gender", label: "Gender", type: "select", options: { "Male": 1, "Female": 0 } },
                { id: "Age", label: "Age", type: "number", min: 1, max: 100, default: 25 },
                { id: "Education_Level", label: "Education Level", type: "select", options: { "High School": 0, "Bachelors": 1, "Masters": 2, "PhD": 3 } },
                { id: "Employment_Status", label: "Employment Status", type: "select", options: { "Unemployed": 0, "Part-time": 1, "Full-time": 2, "Student": 3, "Retired": 4 } }
            ]
        },
        // Step 2: Clinical
        {
            title: "Clinical Awareness",
            questions: [
                { id: "Depression_Type", label: "Reported/Self-identified Depression Type", type: "select", options: { "None / Not Applicable": 0, "Major Depressive": 0, "Bipolar": 2, "Atypical": 7, "Others": 9 } },
                { id: "Symptoms", label: "Primary Symptom", type: "select", options: { "None / Not Applicable": 0, "Persistent Sadness": 0, "Fatigue": 4, "Anxiety": 9, "Sleep Disturbances": 3 } },
                { id: "Depression_Score", label: "Self-assessed Depression Score (0-30)", type: "number", min: 0, max: 30, default: 10 }
            ]
        },
        // Step 3: Emotional Indicators
        {
            title: "Emotional State",
            questions: [
                { id: "Low_Energy", label: "Frequently feeling Low Energy?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Low_SelfEsteem", label: "Feeling of Low Self-Esteem?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Worsening_Depression", label: "Is the feeling worsening recently?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Nervous_Level", label: "Nervousness Level (0-10)", type: "number", min: 0, max: 10, default: 5 }
            ]
        },
        // Step 4: Lifestyle & Habits
        {
            title: "Lifestyle & Habits",
            questions: [
                { id: "Sleep_Hours", label: "Average Sleep Hours per night", type: "number", min: 0, max: 15, default: 7 },
                { id: "SocialMedia_Hours", label: "Social Media Hours per day", type: "number", min: 0, max: 24, default: 3 },
                { id: "How many times you eat ", label: "Eating habits", type: "select", options: { "Irregularly": 0, "Regularly": 1 } },
                { id: "Your overeating level", label: "Overeating level (0-12)", type: "number", min: 0, max: 12, default: 5 }
            ]
        },
        // Step 5: External Factors
        {
            title: "Environment & Support",
            questions: [
                { id: "SocialMedia_WhileEating", label: "Social Media usage while eating?", type: "select", options: { "Never": 0, "Rarely": 1, "Frequently": 2, "Always": 3 } },
                { id: "Mental_Health_Support", label: "Access to Mental Health Support?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Search_Depression_Online", label: "Search about Depression online?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Coping_Methods", label: "Usual Coping Method", type: "select", options: { "Exercise": 0, "Music": 1, "Reading": 2, "Friends/Family": 4, "Self-care": 11 } }
            ]
        },
        // Step 6: Safety
        {
            title: "Safety Assessment",
            questions: [
                { id: "Self_Harm", label: "Current thoughts of Self-Harm?", type: "radio", options: { "Yes": 1, "No": 0 } },
                { id: "Suicide_Attempts", label: "Previous suicide attempts (count)", type: "number", min: 0, max: 5, default: 0 }
            ]
        }
    ];

    // Initialize UI
    function init() {
        renderSteps();
        showStep(0);
    }

    function renderSteps() {
        formStepsContainer.innerHTML = '';
        questions.forEach((step, index) => {
            const stepDiv = document.createElement('div');
            stepDiv.className = `form-step ${index === 0 ? '' : 'hidden'}`;
            stepDiv.id = `step-${index}`;

            const title = document.createElement('h2');
            title.textContent = step.title;
            stepDiv.appendChild(title);

            step.questions.forEach(q => {
                const qBlock = document.createElement('div');
                qBlock.className = 'question-block';

                const label = document.createElement('label');
                label.textContent = q.label;
                qBlock.appendChild(label);

                if (q.type === 'select') {
                    const select = document.createElement('select');
                    select.name = q.id;
                    Object.entries(q.options).forEach(([label, value]) => {
                        const opt = document.createElement('option');
                        opt.value = value;
                        opt.textContent = label;
                        select.appendChild(opt);
                    });
                    qBlock.appendChild(select);
                } else if (q.type === 'number') {
                    const input = document.createElement('input');
                    input.type = 'number';
                    input.name = q.id;
                    input.min = q.min;
                    input.max = q.max;
                    input.value = q.default;
                    qBlock.appendChild(input);
                } else if (q.type === 'radio') {
                    const grid = document.createElement('div');
                    grid.className = 'options-grid';
                    Object.entries(q.options).forEach(([optLabel, optVal]) => {
                        const item = document.createElement('div');
                        item.className = 'option-item';
                        const inputId = `${q.id}-${optVal}`;
                        item.innerHTML = `
                            <input type="radio" name="${q.id}" id="${inputId}" value="${optVal}" ${optVal === 0 ? 'checked' : ''}>
                            <label for="${inputId}">${optLabel}</label>
                        `;
                        grid.appendChild(item);
                    });
                    qBlock.appendChild(grid);
                }

                stepDiv.appendChild(qBlock);
            });

            formStepsContainer.appendChild(stepDiv);
        });
    }

    function showStep(index) {
        document.querySelectorAll('.form-step').forEach(s => s.classList.add('hidden'));
        document.getElementById(`step-${index}`).classList.remove('hidden');

        prevBtn.classList.toggle('hidden', index === 0);

        if (index === questions.length - 1) {
            nextBtn.classList.add('hidden');
            submitBtn.classList.remove('hidden');
        } else {
            nextBtn.classList.remove('hidden');
            submitBtn.classList.add('hidden');
        }

        progressFill.style.width = `${((index + 1) / questions.length) * 100}%`;
        stepIndicator.textContent = `Step ${index + 1} of ${questions.length}`;
    }

    // Event Listeners
    startBtn.addEventListener('click', () => {
        startScreen.classList.add('hidden');
        formScreen.classList.remove('hidden');
    });

    nextBtn.addEventListener('click', () => {
        if (currentStep < questions.length - 1) {
            currentStep++;
            showStep(currentStep);
        }
    });

    prevBtn.addEventListener('click', () => {
        if (currentStep > 0) {
            currentStep--;
            showStep(currentStep);
        }
    });

    const predictionForm = document.getElementById('prediction-form');
    predictionForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        formScreen.classList.add('hidden');
        loadingScreen.classList.remove('hidden');

        const formData = new FormData(predictionForm);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = isNaN(value) ? value : parseFloat(value);
        });

        try {
            const response = await fetch('/predict', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            });

            const result = await response.json();
            displayResults(result);
        } catch (error) {
            alert('Error during prediction. Please check if Flask server is running.');
            loadingScreen.classList.add('hidden');
            formScreen.classList.remove('hidden');
        }
    });

    function displayResults(data) {
        loadingScreen.classList.add('hidden');
        resultsScreen.classList.remove('hidden');

        const header = document.getElementById('result-header');
        const container = document.getElementById('suggestion-container');

        if (data.is_depressed) {
            header.innerHTML = `
                <div class="icon-header">🛑</div>
                <h2 class="res-title" style="color: var(--danger)">Signs of Depression Detected</h2>
                <p class="res-prob">Assessment Confidence: ${(data.probability * 100).toFixed(1)}%</p>
                <div class="res-type">Potential Type: ${data.potential_type}</div>
            `;
        } else {
            header.innerHTML = `
                <div class="icon-header">✅</div>
                <h2 class="res-title" style="color: var(--success)">No Significant Signs Detected</h2>
                <p class="res-prob">Balance Score: ${((1 - data.probability) * 100).toFixed(1)}%</p>
            `;
        }

        container.innerHTML = '<h3>Personalized Recovery Tips:</h3>';
        data.suggestions.forEach(s => {
            const block = document.createElement('div');
            block.className = 'suggestion-block';
            block.innerHTML = `
                <h4>${s.title}</h4>
                <ul>
                    ${s.tips.map(tip => `<li>${tip}</li>`).join('')}
                </ul>
            `;
            container.appendChild(block);
        });
    }

    resetBtn.addEventListener('click', () => {
        resultsScreen.classList.add('hidden');
        startScreen.classList.remove('hidden');
        currentStep = 0;
        predictionForm.reset();
        showStep(0);
    });

    init();
});
