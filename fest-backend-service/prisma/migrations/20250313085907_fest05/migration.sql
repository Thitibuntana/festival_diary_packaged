/*
  Warnings:

  - Added the required column `festNumDay` to the `fest_tb` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `fest_tb` ADD COLUMN `festNumDay` INTEGER NOT NULL;
