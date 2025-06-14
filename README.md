# Salesforce Project

This repository contains a Salesforce project with Lightning Web Components (LWC) and Apex classes.

## Project Structure

```
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/          # Apex classes
│           ├── lwc/             # Lightning Web Components
│           └── aura/            # Aura components
├── scripts/                     # Utility scripts
├── config/                      # Configuration files
└── manifest/                    # Package manifest
```

## Prerequisites

- Node.js (v16 or later)
- Salesforce CLI
- Git

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/mishradeepanshu/mysalesforce.git
   cd mysalesforce
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Authenticate with Salesforce:
   ```bash
   sf org login web
   ```

4. Create a scratch org:
   ```bash
   sf org create scratch -f config/project-scratch-def.json -a myscratchorg
   ```

## Development Workflow

1. Create a new branch for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit them:
   ```bash
   git add .
   git commit -m "Your commit message"
   ```

3. Push your changes:
   ```bash
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request to merge into `develop`

## CI/CD Pipeline

This project uses GitHub Actions for continuous integration and deployment. The pipeline:

1. Runs on push to `main` and `develop` branches
2. Runs on pull requests to `main` and `develop`
3. Deploys to Salesforce org
4. Runs Apex tests

## Available Scripts

- `npm run test`: Run Jest tests
- `npm run lint`: Run ESLint
- `npm run format`: Format code with Prettier

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
