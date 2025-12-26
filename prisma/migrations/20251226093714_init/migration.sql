-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "avatar" TEXT,
    "phone" TEXT,
    CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudentProfile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "profileId" TEXT NOT NULL,
    "university" TEXT NOT NULL,
    "faculty" TEXT NOT NULL,
    "course" INTEGER NOT NULL,
    CONSTRAINT "StudentProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "StudentSkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    CONSTRAINT "StudentSkill_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "StudentProfile" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "OrganizationProfile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "profileId" TEXT NOT NULL,
    "companyName" TEXT NOT NULL,
    "description" TEXT,
    "website" TEXT,
    "logo" TEXT,
    CONSTRAINT "OrganizationProfile_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Resume" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "experience" TEXT NOT NULL,
    "education" TEXT NOT NULL,
    "projects" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Resume_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "StudentProfile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ResumeSkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "resumeId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    "level" TEXT NOT NULL,
    CONSTRAINT "ResumeSkill_resumeId_fkey" FOREIGN KEY ("resumeId") REFERENCES "Resume" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Vacancy" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "salaryFrom" INTEGER,
    "salaryTo" INTEGER,
    "location" TEXT NOT NULL,
    "remote" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "organizationId" TEXT NOT NULL,
    CONSTRAINT "Vacancy_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "OrganizationProfile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "VacancySkill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "vacancyId" TEXT NOT NULL,
    "skill" TEXT NOT NULL,
    "importance" TEXT NOT NULL,
    CONSTRAINT "VacancySkill_vacancyId_fkey" FOREIGN KEY ("vacancyId") REFERENCES "Vacancy" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Application" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "coverLetter" TEXT,
    "appliedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "studentId" TEXT NOT NULL,
    "vacancyId" TEXT NOT NULL,
    CONSTRAINT "Application_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "StudentProfile" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Application_vacancyId_fkey" FOREIGN KEY ("vacancyId") REFERENCES "Vacancy" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Interview" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "applicationId" TEXT NOT NULL,
    "scheduledFor" DATETIME NOT NULL,
    "type" TEXT NOT NULL,
    "location" TEXT,
    "meetingLink" TEXT,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "notes" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Interview_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES "Application" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Message" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "content" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "read" BOOLEAN NOT NULL DEFAULT false,
    "senderId" TEXT NOT NULL,
    "receiverId" TEXT NOT NULL,
    CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Message_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Skill" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_key" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "StudentProfile_profileId_key" ON "StudentProfile"("profileId");

-- CreateIndex
CREATE UNIQUE INDEX "StudentSkill_studentId_skill_key" ON "StudentSkill"("studentId", "skill");

-- CreateIndex
CREATE UNIQUE INDEX "OrganizationProfile_profileId_key" ON "OrganizationProfile"("profileId");

-- CreateIndex
CREATE UNIQUE INDEX "Resume_studentId_key" ON "Resume"("studentId");

-- CreateIndex
CREATE UNIQUE INDEX "ResumeSkill_resumeId_skill_key" ON "ResumeSkill"("resumeId", "skill");

-- CreateIndex
CREATE UNIQUE INDEX "VacancySkill_vacancyId_skill_key" ON "VacancySkill"("vacancyId", "skill");

-- CreateIndex
CREATE UNIQUE INDEX "Application_studentId_vacancyId_key" ON "Application"("studentId", "vacancyId");

-- CreateIndex
CREATE UNIQUE INDEX "Skill_name_key" ON "Skill"("name");
