# 🤖 Moodle 5.0 AI Integration Guide

## Fitur AI yang Tersedia di Moodle 5.0

### **1. Fitur AI untuk Pengajar:**
- ✅ **Generate Course Descriptions** - AI membuat deskripsi kursus otomatis
- ✅ **Create Quiz Content** - AI membuat soal quiz dan pilihan jawaban
- ✅ **Content Generation** - AI membantu membuat materi pembelajaran
- ✅ **Assessment Feedback** - AI memberikan feedback otomatis pada tugas

### **2. Fitur AI untuk Siswa:**
- ✅ **"Explain" Feature** - Siswa bisa bertanya pada AI untuk penjelasan materi
- ✅ **Content Summary** - AI merangkum materi pembelajaran
- ✅ **Writing Assistant** - AI membantu siswa dalam menulis tugas

## Cara Konfigurasi AI Providers

### **Option 1: OpenAI (GPT-4/GPT-3.5)**

#### Step 1: Dapatkan API Key OpenAI
1. Kunjungi https://platform.openai.com/api-keys
2. Login/Register akun OpenAI
3. Create new API key
4. Copy API key (format: sk-...)

#### Step 2: Konfigurasi di Moodle
1. Login sebagai **Site Administrator**
2. Navigasi ke: `Site administration → Plugins → AI → AI providers`
3. Click **"Add new AI provider"**
4. Pilih **"OpenAI"**
5. Isi konfigurasi:

```
Provider name: OpenAI GPT-4
API Key: sk-your-api-key-here
Model: gpt-4 (atau gpt-3.5-turbo untuk yang lebih murah)
API Endpoint: https://api.openai.com/v1
Organization ID: (optional)
Max tokens: 2048
Temperature: 0.7
```

### **Option 2: Ollama (Local AI - Free)**

Ollama memungkinkan Anda menjalankan AI model secara lokal tanpa mengirim data ke cloud.

#### Step 1: Install Ollama
Saya akan buat script untuk install Ollama di Windows:

```cmd
# Download dan install Ollama untuk Windows
# Kunjungi: https://ollama.ai/download/windows
# Atau gunakan command ini di PowerShell:
winget install Ollama.Ollama
```

#### Step 2: Download Model AI
```cmd
# Download model Llama 2 (7B)
ollama pull llama2

# Atau model yang lebih kecil untuk testing
ollama pull phi3:mini
```

#### Step 3: Konfigurasi di Moodle
1. `Site administration → Plugins → AI → AI providers`
2. Add new AI provider → **"Ollama"**
3. Konfigurasi:

```
Provider name: Ollama Local
API Endpoint: http://localhost:11434
Model: llama2 (atau phi3:mini)
Context window: 4096
Temperature: 0.7
```

### **Option 3: Azure OpenAI**

Jika organisasi Anda menggunakan Azure:

1. Setup Azure OpenAI service di Azure Portal
2. Deploy model (GPT-4, GPT-35-turbo)
3. Konfigurasi di Moodle:

```
Provider name: Azure OpenAI
API Key: [your-azure-api-key]
API Endpoint: https://[your-resource].openai.azure.com/
API Version: 2024-02-15-preview
Model deployment: [your-deployment-name]
```

## Mengaktifkan Fitur AI

### **1. Course Description Generation**
- `Site administration → Plugins → AI → AI settings`
- Enable **"AI-powered course descriptions"**
- Set default AI provider

### **2. Quiz Content Generation**
- `Site administration → Plugins → Question bank → AI question generator`
- Enable and configure AI provider for quiz generation

### **3. Student "Explain" Feature**
- `Site administration → Plugins → AI → Student AI assistant`
- Enable **"Explain content feature"**
- Set usage limits per student

## Konfigurasi Environment Variables (Optional)

Untuk keamanan yang lebih baik, Anda bisa set API keys via environment variables.

Di file `.env`:

```env
# OpenAI Configuration
OPENAI_API_KEY=sk-your-openai-api-key-here
OPENAI_ORG_ID=org-your-org-id

# Azure OpenAI Configuration
AZURE_OPENAI_API_KEY=your-azure-key
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/

# Ollama Configuration (jika tidak local)
OLLAMA_API_ENDPOINT=http://localhost:11434
```

## Monitoring & Usage Control

### **1. Set Usage Limits**
- `Site administration → AI → Usage management`
- Set daily/monthly limits per user
- Set cost controls untuk API berbayar

### **2. Monitor AI Usage**
- `Site administration → Reports → AI usage reports`
- Lihat statistik penggunaan AI
- Monitor costs (untuk provider berbayar)

## Security & Privacy

### **1. Data Privacy Settings**
- `Site administration → AI → Privacy settings`
- Configure apakah data dikirim ke external AI providers
- Set data retention policies

### **2. Content Filtering**
- Enable content filtering untuk mencegah inappropriate content
- Set moderation rules

## Testing AI Features

### **1. Test Course Description Generator**
1. Buat course baru
2. Di course settings, click **"Generate with AI"**
3. AI akan create description otomatis

### **2. Test Quiz Generation**
1. Pergi ke Question bank
2. Click **"Generate questions with AI"**
3. Input topic dan jumlah soal yang diinginkan

### **3. Test Student Explain Feature**
1. Login sebagai student
2. Di materi pembelajaran, akan ada button **"Explain"**
3. Click untuk mendapat penjelasan AI

## Troubleshooting

### **Common Issues:**

1. **API Key Invalid**
   - Pastikan API key benar dan masih aktif
   - Check billing account untuk OpenAI

2. **Ollama Connection Failed**
   - Pastikan Ollama service running: `ollama serve`
   - Check firewall settings

3. **Rate Limits Exceeded**
   - Adjust usage limits di Moodle
   - Upgrade OpenAI plan jika perlu

## Cost Considerations

### **OpenAI Pricing (approx):**
- GPT-4: $0.03 per 1K input tokens, $0.06 per 1K output tokens
- GPT-3.5-turbo: $0.001 per 1K input tokens, $0.002 per 1K output tokens

### **Free Alternatives:**
- Ollama (completely free, runs locally)
- Google Gemini (has free tier)
- Anthropic Claude (limited free usage)

## Next Steps

1. **Choose your AI provider** based on budget and requirements
2. **Start with one feature** (e.g., course descriptions)
3. **Train your teachers** on AI features
4. **Monitor usage and costs**
5. **Gradually enable more AI features**

## Useful Links

- [Moodle 5.0 AI Documentation](https://docs.moodle.org/50/en/AI)
- [OpenAI API Documentation](https://platform.openai.com/docs)
- [Ollama Documentation](https://ollama.ai/docs)
- [Azure OpenAI Documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/openai/)
