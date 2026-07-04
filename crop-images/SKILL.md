---
name: crop-images
description: Render PDF pages or document images, visually identify scientific figures/charts/photos, return pixel bounding boxes, and crop each target image into named PNG files. Use when the user asks to convert PDF pages to images, find figure coordinates, crop figures from manuscripts, extract charts/photos/diagrams, name crops as F1/F2/etc., or place cropped images next to the source PDF.
---

# Crop Images

## Overview

Crop scientific figures from PDFs by rendering pages first, inspecting the rendered pages, recording pixel bounding boxes, and cutting final PNGs from the rendered page images. Default to 300 DPI unless the user requests another resolution.

## Coordinate Rules

- Report every bbox as `[x0,y0,x1,y1]` in pixels on the rendered page image.
- Use the top-left page corner as `(0,0)`.
- Treat `x1,y1` as the lower-right crop edge.
- Include page size, DPI, page number, output filename, and caption/description in the manifest.
- If the user asks for names like "Figure 2 -> F2", name crops exactly `F2.png`.

## Step-by-step Workflow

1. Verify the source file.
   - Confirm the path exists and is a PDF or image.
   - For PDFs, run `pdfinfo` to get page count and page size.
   - Use the bundled/runtime Poppler tools when available; otherwise use system `pdftoppm` and `pdfinfo`.

2. Render pages.
   - Render at 300 DPI by default: `pdftoppm -r 300 -png "$PDF" "$WORK/page"`.
   - Keep rendered pages in a work directory, not mixed with final crops.
   - Record rendered page size before reporting coordinates.

3. Make a page contact sheet.
   - Use ImageMagick `magick montage` when available.
   - Identify pages containing scientific figures, charts, photos, diagrams, or microscopy/experiment images.
   - Do not crop tables, formulas, references, captions, or highlighted body text unless the user asks.

4. Inspect target pages at full resolution.
   - Open each target page image and choose a tight bbox around the figure content.
   - Preserve all axes, labels, legends, subfigure labels, scale bars, arrows, and in-image annotations.
   - Usually exclude the caption. Include only subfigure labels like `(a)` and `(b)` when they are visually part of the figure panel.
   - If a figure spans pages, crop each visible page segment separately and note it.

5. Prepare a bbox JSON file.
   - Use one object per crop:

```json
[
  {
    "name": "F1",
    "page": 4,
    "bbox": [278, 255, 2242, 810],
    "caption": "Sandwich plate geometry and coordinate system"
  }
]
```

6. Crop and write manifests.
   - Prefer `scripts/crop_pdf_images.py` for repeatable rendering, cropping, manifest writing, and contact sheets.
   - Put final crops in an output folder named after the source, for example `<pdf-stem>_figures_300dpi`.
   - If the user asks to place outputs beside the PDF and that path is outside the writable workspace, request escalation before copying/writing there.

7. Verify visually.
   - Build a crop contact sheet.
   - Build annotated pages with red rectangles around each bbox.
   - Inspect the contact sheet and at least each page containing multiple crops.
   - If any crop clips a label, axis, legend, scale bar, or visible figure content, adjust the bbox and regenerate.

8. Report results.
   - Provide a short table of `name`, `page`, `bbox`, and filename.
   - Link the output folder, manifest CSV/JSON, and contact sheet.
   - State the DPI and rendered page size.

## Script

Use `scripts/crop_pdf_images.py` for the mechanical parts.

Render only:

```bash
python3 scripts/crop_pdf_images.py manuscript.pdf --dpi 300 --work-dir work/pages --out-dir outputs/crops --render-only
```

Render and crop:

```bash
python3 scripts/crop_pdf_images.py manuscript.pdf --dpi 300 --work-dir work/pages --out-dir outputs/crops --bbox-json bboxes.json
```

Self-check:

```bash
python3 scripts/crop_pdf_images.py --self-check
```

## Practical Defaults

- Default DPI: 300.
- Default crop names: `F1.png`, `F2.png`, etc., matching figure numbers when captions are clear.
- Default output folder: `<source-stem>_figures_<dpi>dpi`.
- Keep raw rendered pages in `work/` and final user-facing crops in the requested output location.
- Use `pdftotext` plus `rg "Figure [0-9]"` to cross-check caption count, but trust visual inspection for final bbox selection.
