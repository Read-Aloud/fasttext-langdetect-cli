# fasttext-langdetect-cli
Docker image to perform language detection using the fastText library

## Usage

```powershell
'hello this is a short english sentence' | docker run --rm -i ken107/fasttext-langdetect-cli
```

The image builds fastText inside Docker with generic CPU tuning so the runtime
binary is not tied to the instruction set of the machine that built the image.
