/*
  Warnings:

  - You are about to drop the column `festNumDay` on the `fest_tb` table. All the data in the column will be lost.
  - Added the required column `festNumDay01` to the `fest_tb` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `fest_tb` DROP COLUMN `festNumDay`,
    ADD COLUMN `festNumDay01` INTEGER NOT NULL;
