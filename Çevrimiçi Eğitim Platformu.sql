-- 1. Üyeler Tablosu
CREATE TABLE members (
    member_id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Eğitimler Tablosu
CREATE TABLE courses (
    course_id BIGSERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE,
    instructor_name VARCHAR(100)
);

-- 3. Kategoriler Tablosu
CREATE TABLE categories (
    category_id SMALLSERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- 4. Eğitim-Kategori İlişkisi
CREATE TABLE course_categories (
    course_id BIGINT NOT NULL,
    category_id SMALLINT NOT NULL,
    PRIMARY KEY (course_id, category_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-- 5. Katılımlar Tablosu
CREATE TABLE enrollments (
    enrollment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 6. Sertifikalar Tablosu
CREATE TABLE certificates (
    certificate_id BIGSERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issued_date DATE DEFAULT CURRENT_DATE
);

-- 7. Sertifika Atamaları Tablosu
CREATE TABLE certificate_assignments (
    assignment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT NOT NULL,
    certificate_id BIGINT NOT NULL,
    received_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (certificate_id) REFERENCES certificates(certificate_id) ON DELETE CASCADE
);

-- 8. Blog Gönderileri Tablosu
CREATE TABLE blog_posts (
    post_id BIGSERIAL PRIMARY KEY,
    writer_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (writer_id) REFERENCES members(member_id) ON DELETE CASCADE
);



------------------------------------------------------------------------

INSERT INTO members (username, email, password, first_name, last_name)
VALUES
('enes1', 'enes@example.com', 'hashedpass1', 'Enes', 'Aktaş'),
('agit2', 'agit@example.com', 'hashedpass2', 'Agit', 'Çetin'),
('dilara3', 'mehmet@example.com', 'hashedpass3', 'Dilara', 'Uzan'),
('tuna4', 'tuna@example.com', 'hashedpass4', 'Tuna', 'Uzan'),
('doga5', 'doga@example.com', 'hashhedpass5', 'Doga', 'Kara'),
('aynur6', 'aynur@example.com', 'hashhedpass6', 'Aynur','Akyüz'),
('kübra7', 'kübra@example.com', 'hashhedpass7', 'Kübra', 'Tek');


INSERT INTO categories (category_name)
VALUES
('Yapay Zeka'),
('Blokzincir'),
('Siber Güvenlik');

INSERT INTO courses (course_name, description, start_date, end_date, instructor_name)
VALUES
('Makine Öğrenmesi ve Yapay Zeka', 'Yapay Zekanın Teknoloji Dünyasına Etkileri', '2025-04-27', '2025-06-27', 'Selin Dinç'),
('Blokzincir 101', 'Blokzincirin Temelleri', '2025-07-19', '2025-08-19', 'Canan Uçar'),
('Siber Güvenlik Dünyasına Giriş', 'Adli Bilişim ve Sızma Testleri', '2025-09-20', '2025-09-30', 'Halil Öz');

-- 1. kurs -> Yapay Zeka
INSERT INTO course_categories (course_id, category_id) VALUES (1, 1);

-- 2. kurs -> Blokzincir
INSERT INTO course_categories (course_id, category_id) VALUES (2, 2);

-- 3. kurs -> Siber Güvenlik
INSERT INTO course_categories (course_id, category_id) VALUES (3, 3);


INSERT INTO enrollments (member_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 2),
(4, 3),
(5, 1),
(6, 1),
(6, 2),
(6, 3),
(7, 2);


INSERT INTO certificates (certificate_code, issued_date)
VALUES
('CERT-YZ123', '2025-10-30'),
('CERT-BZ456', '2025-10-30'),
('CERT-SG789', '2025-10-30');

INSERT INTO certificate_assignments (member_id, certificate_id, received_date)
VALUES
(1, 1, '2025-11-28'),
(1, 2, '2025-11-29'),
(2, 1, '2025-11-28'),
(3, 3, '2025-11-30'),
(4, 2, '2025-11-29'),
(4, 3, '2025-11-30'),
(5, 1, '2025-11-28'),
(6, 1, '2025-11-28'),
(6, 2, '2025-11-29'),
(6, 3, '2025-11-30'),
(7, 2, '2025-11-29');


INSERT INTO blog_posts (writer_id, title, content)
VALUES
(1, 'Yapay Zeka ve İş', 'Yapay Zekanın İş Dünyasına Etkileri Nelerdir?'),
(2, 'Blokzincir Nasıl Çalışır?', 'Blokzincir Teknolojisinin Çalışma Prensipleri'),
(3, 'Etik Hackerlık Nedir?', 'Siber Güvenlikte Şapkalı Hacker Olmak Ne Demek?');







